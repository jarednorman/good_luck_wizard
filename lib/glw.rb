require 'curses'

require "glw/version"

module GLW
  class << self
    def start!
      Curses.init_screen
      Curses.start_color
      Curses.use_default_colors
      Curses.curs_set(0)
      Curses.noecho

      win = Curses::Window.new(0, 0, 0, 0)
      win.setpos(0, 0)
      win << "@"
      win.refresh

      sleep 1

      win.setpos(0, 0)
      win << " "
      win.setpos(1, 1)
      win << "@"

      win.refresh

      sleep 1

      Curses.close_screen
    end
  end
end
