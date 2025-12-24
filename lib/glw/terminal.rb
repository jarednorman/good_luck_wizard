module GLW
  module Terminal
    class << self
      PALETTE = {
        black: [0, 0, 0],
        white: [255, 255, 255]
      }.transform_values do |(r, g, b)|
        [
          "\e[38;2;#{r};#{g};#{b}m",
          "\e[48;2;#{r};#{g};#{b}m"
        ]
      end.freeze

      def move_to(x, y)
        "\e[#{y + 1};#{x + 1}H"
      end

      def set_fg(color)
        PALETTE.fetch(color)[0]
      end

      def set_bg(color)
        PALETTE.fetch(color)[1]
      end

      def hide_cursor
        "\e[?25l"
      end
    end
  end
end
