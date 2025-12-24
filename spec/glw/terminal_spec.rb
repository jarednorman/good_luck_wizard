# frozen_string_literal: true

RSpec.describe GLW::Terminal do
  describe ".move_to" do
    it "generates ANSI escape sequence for cursor position" do
      expect(described_class.move_to(0, 0)).to eq "\e[1;1H"
    end

    it "converts zero-based coordinates to one-based ANSI coordinates" do
      expect(described_class.move_to(5, 10)).to eq "\e[11;6H"
    end
  end

  describe ".set_fg" do
    it "returns foreground color escape sequence for the specified colour" do
      expect(described_class.set_fg(:black)).to eq "\e[38;2;0;0;0m"
    end

    it "raises KeyError for unknown color" do
      expect { described_class.set_fg(:wizard) }.to raise_error KeyError
    end
  end

  describe ".set_bg" do
    it "returns background color escape sequence for the specified colour" do
      expect(described_class.set_bg(:white)).to eq "\e[48;2;255;255;255m"
    end

    it "raises KeyError for unknown color" do
      expect { described_class.set_bg(:wizard) }.to raise_error KeyError
    end
  end

  describe ".hide_cursor" do
    it "returns ANSI escape sequence to hide the cursor" do
      expect(described_class.hide_cursor).to eq "\e[?25l"
    end
  end
end
