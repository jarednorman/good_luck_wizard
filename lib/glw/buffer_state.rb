module GLW
  BufferState = Data.define(:width, :height, :cells) do
    def self.blank(height:, width:)
      new(
        width,
        height,
        Array.new(height * width) { ScreenCell.blank }
      )
    end

    def [](x, y)
      cells[y * width + x]
    end
  end
end
