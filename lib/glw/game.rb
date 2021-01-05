module GLW
  class Game
    def initialize
      @player_x = 0
      @player_y = 0
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
  end
end
