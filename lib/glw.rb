require 'curses'
require "zeitwerk"

require "glw/version"

module GLW
  class << self
    def start!
      initialize_zeitwerk

      GLW::Term.with_term do |t|
        g = Game.new

        loop do
          player_x, player_y = *g.player_position

          t.set(
            x: player_x,
            y: player_y,
            c: "@",
            fg: 226,
            bg: 89
          )

          t.refresh

          t.set(
            x: player_x,
            y: player_y,
            c: " ",
            bg: 180
          )

          break if g.send_key(t.getch) == :quit
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
