module GLW
  ScreenCell = Data.define(:char, :fg_color, :bg_color) do
    def self.blank
      @blank ||= new(' ', :black, :black)
    end

    def char=(other)
      self.class.new(other, fg_color, bg_color)
    end

    def fg_color=(other)
      self.class.new(char, other, bg_color)
    end

    def bg_color=(other)
      self.class.new(char, fg_color, other)
    end
  end
end
