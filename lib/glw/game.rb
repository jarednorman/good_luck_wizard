module GLW
  class Game
    MAP = <<~TXT
      ############
      #..........#          ##########
      #..........############....#...#
      #..............................#
      #.......g..############....#...#
      #..........#          #....#...#
      ############          ##########
    TXT

    def initialize(term:)
      @player_x = 3
      @player_y = 3
      @term = term
      @map = MAP.lines.map(&:chars)
    end

    def send_key(key)
      case key
      when "q"
        :quit
      when "h"
        @player_x -= 1 if valid_player_position?(@player_x - 1, @player_y)
      when "l"
        @player_x += 1 if valid_player_position?(@player_x + 1, @player_y)
      when "k"
        @player_y -= 1 if valid_player_position?(@player_x, @player_y - 1)
      when "j"
        @player_y += 1 if valid_player_position?(@player_x, @player_y + 1)
      end
    end

    def valid_player_position?(x, y)
      @map[y][x] == "."
    end

    def render
      @map.each_with_index do |line, y|
        line.each_with_index do |c, x|
          next if [x, y] == [@player_x, @player_y]
          term.set(
            x: x,
            y: y,
            c: c
          )
        end
      end

      term.set(
        x: @player_x,
        y: @player_y,
        c: "@",
        fg: 220
      )

      term.refresh
    end

    private

    attr_reader :term
  end
end
