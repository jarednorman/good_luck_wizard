module GLW
  module Screen
    class << self
      def start!
        @render_queue = Thread::Queue.new

        @render_queue.push BufferState.blank(
          height: IO.console.winsize[0],
          width: IO.console.winsize[1]
        )

        Thread.new do
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

        # Phase 1 & 2: Detect changes and build contiguous horizontal blocks
        state.cells.each_with_index do |cell, index|
          next if last_state && cell == last_state.cells[index]

          # Convert linear index to (x, y) coordinates
          y = index / state.width
          x = index % state.width

          # Check if this cell continues the current block
          if current_block && current_block[:y] == y &&
             current_block[:x] + current_block[:cells].length == x
            current_block[:cells] << cell
          else
            # Save current block if it exists
            updates << current_block if current_block

            # Start new block
            current_block = { x: x, y: y, cells: [cell] }
          end
        end

        # Don't forget to save the last block
        updates << current_block if current_block

        # Phase 3: Build output string with color optimization
        output = ''
        current_fg = nil
        current_bg = nil

        updates.each do |block|
          output << Terminal.move_to(block[:x], block[:y])

          block[:cells].each do |cell|
            if cell.fg_color != current_fg
              output << Terminal.set_fg(cell.fg_color)
              current_fg = cell.fg_color
            end

            if cell.bg_color != current_bg
              output << Terminal.set_bg(cell.bg_color)
              current_bg = cell.bg_color
            end

            output << cell.char
          end
        end

        # Phase 4: Single write
        STDOUT.print output
        STDOUT.flush
      end
    end
  end
end
