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

        loop do
          content = input.pop

          exit(0) if content == :k_escape || content == :k_ctrl_c
        end
      end
    rescue
      raise
    end
  end
end
