module GLW::Term
  class << self
    def with_term
      Curses.init_screen
      Curses.start_color
      Curses.curs_set(0)
      Curses.noecho

      Curses.assume_default_colors(255, 16)
      win = Curses::Window.new(0, 0, 0, 0)
      win.setpos(0, 0)
      win << "@"
      win.refresh

      yield

      Curses.close_screen
    end
  end
end
