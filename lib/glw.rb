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

        loop do
          content = STDIN.readpartial(1)

          exit(0) if content == "Q"
        end
      end
    end
  end
end
