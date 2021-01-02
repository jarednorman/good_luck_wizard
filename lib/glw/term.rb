module GLW
  # This class is responsible for handling all interactions with the terminal
  # so that this thing can be half-ways frontend independent, though I have no
  # intention of ever switching frontends.
  class Term
    DEFAULT_FG = 255
    DEFAULT_BG = 16

    Cell = Struct.new(:c, :fg, :bg)

    DEFAULT_CELL = Cell.new(" ", DEFAULT_FG, DEFAULT_BG)

    class << self
      def with_term
        Curses.init_screen
        Curses.start_color
        Curses.curs_set(0)
        Curses.noecho

        Curses.assume_default_colors(DEFAULT_FG, DEFAULT_BG)

        yield new(Curses::Window.new(0, 0, 0, 0))
      ensure
        Curses.close_screen
      end
    end

    def initialize(window)
      @window = window
      @tiles = Hash.new { DEFAULT_CELL }
      @next_tiles = {}
    end

    def set(x:, y:, c:, fg: DEFAULT_FG, bg: DEFAULT_BG)
      cell = Cell.new(c, fg, bg)

      @next_tiles[[x, y]] = cell unless @tiles[[x, y]] == cell
    end

    def width
      Curses.cols
    end

    def height
      Curses.lines
    end

    def getch
      window.getch
    end

    def refresh
      @next_tiles.each do |coords, cell|
        window.setpos *coords.reverse
        window << cell.c
      end

      @tiles = @tiles.merge(@next_tiles)

      window.refresh
    end

    private

    attr_reader :window
  end
end
