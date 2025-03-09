require "curses"

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
      initialize_zeitwerk

      GLW::Term.with_term do |t|
        g = Game.new(term: t)

        loop do
          g.render
          break if g.send_key(t.getch) == :quit
        end
      end
    end

    def initialize_zeitwerk
    end
  end
end
