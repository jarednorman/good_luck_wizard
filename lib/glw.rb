require "io/console"

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
      # Read input until we get a "q" then exist.
      IO.console.raw do
        loop do
          content = STDIN.readpartial(1)
          STDOUT.write(content.inspect)
          exit(0) if content == 'Q'
        end
      end
    end
  end
end
