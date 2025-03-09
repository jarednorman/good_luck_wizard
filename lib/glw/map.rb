module GLW
  class Map
    MAP = <<~TXT
      ############
      #..........#          ##########
      #..........############....#...#
      #..............................#
      #.......g..############....#...#
      #..........#          #....#...#
      ############          ##########
    TXT

    def initialize
      @player_x = 3
      @player_y = 3

      @map = Hash.new(" ")
      MAP.lines.each_with_index do |line, y|
        line.chars.each_with_index do |c, x|
          @map[[x, y]] = c
        end
      end

      @offset_x = 1
      @offset_y = 1
    end

    def send_event(e)
      case e
      when :left
        @player_x -= 1 if valid_player_position?(@player_x - 1, @player_y)
      when :right
        @player_x += 1 if valid_player_position?(@player_x + 1, @player_y)
      when :up
        @player_y -= 1 if valid_player_position?(@player_x, @player_y - 1)
      when :down
        @player_y += 1 if valid_player_position?(@player_x, @player_y + 1)
      end
    end

    def render(term, width:, height:)
      (0..width - 1).each do |x|
        (0..height - 1).each do |y|
          if [@player_x + @offset_x, @player_y + @offset_y] == [x, y]
            term.set(
              x: x,
              y: y,
              c: "@",
              fg: 220
            )
          else
            term.set(
              x: x,
              y: y,
              c: @map[[x - @offset_x, y - @offset_y]]
            )
          end
        end
      end

      term.refresh
    end

    private

    def valid_player_position?(x, y)
      @map[[x, y]] == "."
    end
  end
end
