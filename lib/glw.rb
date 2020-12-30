require 'curses'
require "zeitwerk"

require "glw/version"

module GLW
  class << self
    def start!
      initialize_zeitwerk

      GLW::Term.with_term do |t|
        t.set(x: 0, y: 0, c: "@")
        t.refresh
        sleep 1

        t.set(x: 0, y: 0, c: " ")
        t.set(x: 2, y: 1, c: "@")
        t.refresh
        sleep 1
      end
    end

    private

    def initialize_zeitwerk
      Zeitwerk::Loader.new.tap do |loader|
        loader.inflector.inflect("glw" => "GLW")
        loader.push_dir(__dir__)
        loader.setup
      end
    end
  end
end
