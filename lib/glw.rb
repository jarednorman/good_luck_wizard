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
        Screen.start!
        Input.start!

        loop do
          content = Input.pop

          exit(0) if content == :k_escape || content == :k_ctrl_c
        end
      end
    rescue
      raise
    end
  end
end
