module GLW
  ScreenCell = Data.define(:char, :fg_color, :bg_color) do
    def self.blank
      @blank ||= new(" ", :black, :black)
    end
  end
end
