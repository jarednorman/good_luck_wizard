require 'curses'
require "zeitwerk"

require "glw/version"

module GLW
  class << self
    def start!
      initialize_zeitwerk

      GLW::Term.with_term do |t|
        loop do
          t.width.times do |x|
            t.height.times do |y|
              if rand(0..10) == 0
                t.set(x: x, y: y, c: %w[
                  #
                  @
                  .
                  g
                  r
                  +
                  =
                ].sample)
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
