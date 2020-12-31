require 'curses'
require "zeitwerk"

require "glw/version"

module GLW
  class << self
    def start!
      initialize_zeitwerk

      r = Random.new(123456789)

      GLW::Term.with_term do |t|
        loop do
          t.width.times do |x|
            t.height.times do |y|
              if r.float < 0.1
                t.set(x: x, y: y, c: r.sample(%w[
                  #
                  @
                  .
                  g
                  r
                  +
                  =
                ]))
              else
                t.set(x: x, y: y, c: " ")
              end
            end
          end
          t.refresh
          break if t.getch == "q"
        end
      end
    end

    def initialize_zeitwerk
      return if @zeitwerk_enabled

      Zeitwerk::Loader.new.tap do |loader|
        loader.inflector.inflect("glw" => "GLW")
        loader.push_dir(__dir__)
        loader.setup
      end

      @zeitwerk_enabled = true
    end
  end
end
