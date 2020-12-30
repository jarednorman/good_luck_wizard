module GLW
  # This class is responsible for handling all interactions with the terminal
  # so that this thing can be half-ways frontend independent, though I have no
  # intention of ever switching frontends.
  class Term
    class << self
      def with_term
        Curses.init_screen
        Curses.start_color
        Curses.curs_set(0)
        Curses.noecho

        Curses.assume_default_colors(255, 16)

        yield new(Curses::Window.new(0, 0, 0, 0))
      ensure
        Curses.close_screen
      end
    end
  end
end
