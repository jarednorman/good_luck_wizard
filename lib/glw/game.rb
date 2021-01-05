module GLW
  class Game
    MAP = <<~TXT
      ############          ######
      #..........#          #....#
      #..........############....#
      #..........................#
      #..........############....#
      #..........#          #....#
      ############          ######
    TXT

    def initialize(term:)
      @player_x = 3
      @player_y = 3
      @term = term
      @map = MAP.lines.map(&:chars)
    end

    def player_position
      [@player_x, @player_y]
    end

    def send_key(key)
      case key
      when "q"
        :quit
      when "h"
        @player_x -= 1
      when "l"
        @player_x += 1
      when "k"
        @player_y -= 1
      when "j"
        @player_y += 1
      end
    end

    def render
      player_x, player_y = *player_position

      @map.each_with_index do |line, y|
        line.each_with_index do |c, x|
          term.set(
            x: x,
            y: y,
            c: c
          )
        end
      end

      term.set(
        x: player_x,
        y: player_y,
        c: "@",
        fg: 220
      )

      term.refresh
    end

    private

    attr_reader :term
  end
end
