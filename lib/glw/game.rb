module GLW
  class Game
    def initialize
      @player_x = 0
      @player_y = 0
    end

    def player_position
      [@player_x, @player_y]
    end

    def move_player(dx, dy)
      @player_x += dx
      @player_y += dy
    end
  end
end
