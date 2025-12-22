module GLW
  module Screen
    class << self
      def start!
        Thread.new do
          last_state = nil
          loop do
            state = render_queue.pop

            # Throw away stale states until we have the newest one.
            until render_queue.empty?
              state = render_queue.pop
            end

            render(last_state, state)
          end
        end
      end

      def push_state(state)
        render_queue.push(state)
      end

      private

      def render(last_state, state)
        if last_state.nil?
          Terminal.move_to(0, 0)

          cell = state[0, 0]
          current_fg = cell.fg_color
          current_bg = cell.bg_color

          Terminal.set_fg(current_fg)
          Terminal.set_bg(current_bg)

          state.cells.each_with_index do |cell, index|
            if cell.fg_color != current_fg
              Terminal.set_fg(cell.fg_color)
              current_fg = cell.fg_color
            end

            if cell.bg_color != current_bg
              Terminal.set_bg(cell.bg_color)
              current_bg = cell.bg_color
            end

            STDOUT.print(cell.char)
          end

          Terminal.move_to(
            state.width - 1,
            state.height - 1
          )
        end
      end

      def render_queue
        @render_queue ||= Thread::Queue.new
      end
    end
  end
end
