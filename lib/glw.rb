require "zeitwerk"
require "io/console"

Zeitwerk::Loader.for_gem.tap do |loader|
  loader.inflector.inflect(
    "glw" => "GLW"
  )

  loader.setup
end

module GLW
  class << self
    def start!
      Terminal.with do |terminal|
      end
    end
  end
end
