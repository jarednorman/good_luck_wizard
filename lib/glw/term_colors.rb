module GLW
  class TermColors
    def initialize(curses = Curses)
      index = 1

      @colors = Hash.new do |hash, key|
        fg, bg = *key

        curses.init_pair(index, fg, bg)
        hash[key] = curses.color_pair(index)

        index += 1

        hash[key]
      end
    end

    def [](fg, bg)
      @colors[[fg, bg]]
    end
  end
end
