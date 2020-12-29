require 'curses'

require "glw/version"

module GLW
  class << self
    def start!
      Curses.init_screen
      Curses.start_color
      Curses.curs_set(0)
      Curses.noecho

      Curses.init_pair(1, 2, 1)
      win = Curses::Window.new(0, 0, 0, 0)
      win.setpos(0, 0)
      win << "started"
      win.refresh

      sleep 3

      Curses.close_screen
    end
  end
end
