require "io/console"
require "concurrent/actor"

require "zeitwerk"

Zeitwerk::Loader.for_gem.tap do |loader|
  loader.inflector.inflect(
    "glw" => "GLW"
  )

  loader.setup
end

module GLW
  class << self
    def start!
      IO.console.raw do
        screen = Screen.new
        input = Input.new

        screen.start!
        input.start!

        universe = Universe.new

        target_fps = 20
        frame_time = 1.0 / target_fps

        loop do
          frame_start = Time.now

          until input.empty?
            key = input.pop

            exit(0) if key == :k_escape || key == :k_ctrl_c

            universe.singletons[Components::Input].push key
          end

          height, width = *IO.console.winsize
          buffer = universe.render(width:, height:)
          screen.push_state(buffer)

          elapsed = Time.now - frame_start
          sleep(frame_time - elapsed) if elapsed < frame_time
        end
      end
    end
  end
end
