module GLW
  class Game
    def initialize(term:)
      @map = Map.new
      @term = term
    end

    def send_key(key)
      case key
      when "q"
        :quit
      when "h"
        @map.send_event :left
      when "l"
        @map.send_event :right
      when "k"
        @map.send_event :up
      when "j"
        @map.send_event :down
      end
    end

    def render
      map.render(term, width: term.width - 60, height: term.height)
    end

    private

    attr_reader :term, :map
  end
end
