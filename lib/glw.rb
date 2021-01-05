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
          case t.getch
          when "q" then break
          when "h"
            g.move_player -1, 0
          when "l"
            g.move_player 1, 0
          when "k"
            g.move_player 0, -1
          when "j"
            g.move_player 0, 1
          end
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
