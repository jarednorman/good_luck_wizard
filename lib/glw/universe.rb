module GLW
  class Universe
    def singletons
      @singletons ||= Hash.new { |h, k| h[k] = k.make }
    end

    def render(width:, height:)
      BufferState.blank(width:, height:)
    end
  end
end
