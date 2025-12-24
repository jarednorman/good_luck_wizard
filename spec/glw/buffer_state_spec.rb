# frozen_string_literal: true

RSpec.describe GLW::BufferState do
  describe ".blank" do
    subject { described_class.blank(height: 3, width: 4) }

    it "creates a buffer with correct dimensions" do
      aggregate_failures do
        expect(subject.width).to eq 4
        expect(subject.height).to eq 3
      end
    end

    it "creates correct number of cells" do
      expect(subject.cells.size).to eq(12)
    end

    it "populates all cells with blank cells" do
      expect(subject.cells).to all eq GLW::ScreenCell.blank
    end
  end

  describe "initialization" do
    it "creates a buffer with the specified cells" do
      buffer = described_class.new(2, 2, [
        GLW::ScreenCell.new("A", :white, :black),
        GLW::ScreenCell.new("B", :white, :black),
        GLW::ScreenCell.new("C", :white, :black),
        GLW::ScreenCell.new("D", :white, :black)
      ])

      aggregate_failures do
        expect(buffer.width).to eq 2
        expect(buffer.height).to eq 2
        expect(buffer.cells).to eq [
          GLW::ScreenCell.new("A", :white, :black),
          GLW::ScreenCell.new("B", :white, :black),
          GLW::ScreenCell.new("C", :white, :black),
          GLW::ScreenCell.new("D", :white, :black)
        ]
      end
    end
  end

  describe "#[]" do
    let(:cells) {
      [
        GLW::ScreenCell.new("A", :white, :black),
        GLW::ScreenCell.new("B", :white, :black),
        GLW::ScreenCell.new("C", :white, :black),
        GLW::ScreenCell.new("D", :white, :black),
        GLW::ScreenCell.new("E", :white, :black),
        GLW::ScreenCell.new("F", :white, :black)
      ]
    }
    let(:buffer) { described_class.new(3, 2, cells) }

    it "correctly calculates index as y * width + x" do
      aggregate_failures do
        expect(buffer[0, 0]).to eq(cells[0])
        expect(buffer[1, 0]).to eq(cells[1])
        expect(buffer[2, 0]).to eq(cells[2])
        expect(buffer[0, 1]).to eq(cells[3])
        expect(buffer[1, 1]).to eq(cells[4])
        expect(buffer[2, 1]).to eq(cells[5])
      end
    end
  end
end
