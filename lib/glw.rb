require 'curses'
require "zeitwerk"

require "glw/version"

module GLW
  class << self
    def start!
      initialize_zeitwerk

      GLW::Term.with_term do |t|
        player_x = 0
        player_y = 0

        loop do

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
            player_x -= 1
          when "l"
            player_x += 1
          when "k"
            player_y -= 1
          when "j"
            player_y += 1
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
