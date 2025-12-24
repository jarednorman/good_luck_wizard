module GLW
  module Screen
    class << self
      UpdateBlock = Data.define(:start_index, :cells) do
        def self.make(start_index) = new(start_index, [])

        def to_s(current_fg: nil, current_bg: nil)
          output = ""
          fg = current_fg
          bg = current_bg

          cells.each do |cell|
            if cell.fg_color != fg
              output << Terminal.set_fg(cell.fg_color)
              fg = cell.fg_color
            end

            if cell.bg_color != bg
              output << Terminal.set_bg(cell.bg_color)
              bg = cell.bg_color
            end

            output << cell.char
          end

          [output, fg, bg]
        end
      end

      def start!
        @render_queue = Thread::Queue.new

        @render_queue.push BufferState.blank(
          height: IO.console.winsize[0],
          width: IO.console.winsize[1]
        )

        Thread.new do
          STDOUT.print Terminal.hide_cursor

          last_state = nil

          loop do
            state = @render_queue.pop

            # Throw away stale states until we have the newest one.
            state = @render_queue.pop until @render_queue.empty?

            render(last_state, state)
            last_state = state
          end
        end
      end

      def push_state(state)
        @render_queue.push(state)
      end

      private

      def render(last_state, state)
        updates = []
        current_block = nil

        state.cells.each_with_index do |cell, index|
          next if last_state && cell == last_state.cells[index]

          if current_block && current_block.start_index + current_block.cells.length == index
            current_block.cells << cell
          else
            updates << current_block if current_block

            current_block = UpdateBlock.new(index, [cell])
          end
        end

        updates << current_block if current_block

        current_fg = nil
        current_bg = nil

        STDOUT.print(
          updates.flat_map do |block|
            y = block.start_index / state.width
            x = block.start_index % state.width

            block_output, current_fg, current_bg = block.to_s(
              current_fg:,
              current_bg:
            )

            [
              Terminal.move_to(x, y),
              block_output
            ]
          end.join
        )

        STDOUT.flush
      end
    end
  end
end
