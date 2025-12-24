module GLW
  class Universe
    def initialize
      # ECS setup will go here
    end

    def handle_input(key)
      # Process player input, trigger turn
    end

    def render(width:, height:)
      BufferState.blank(width:, height:)
    end
  end
end
