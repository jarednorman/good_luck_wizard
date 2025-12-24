# frozen_string_literal: true

RSpec.describe GLW::ScreenCell do
  describe ".blank" do
    subject(:blank_cell) { described_class.blank }

    it "returns a blank cell with default values" do
      aggregate_failures do
        expect(blank_cell.char).to eq(" ")
        expect(blank_cell.fg_color).to eq(:black)
        expect(blank_cell.bg_color).to eq(:black)
      end
    end

    it "returns the same instance on repeated calls (singleton)" do
      expect(blank_cell).to be(described_class.blank)
    end
  end

  describe "#with" do
    subject { cell.with(char: "C", fg_color: :white, bg_color: :black) }

    let(:cell) { described_class.new("A", :red, :blue) }

    it "returns a new ScreenCell with updated attributes" do
      new_cell = subject
      expect(new_cell.char).to eq("C")
      expect(new_cell.fg_color).to eq(:white)
      expect(new_cell.bg_color).to eq(:black)
      expect(new_cell).not_to be(cell)
    end

    context "when only updating some attributes" do
      subject { cell.with(fg_color: :white) }

      it "returns a new ScreenCell with only specified attributes updated" do
        new_cell = subject
        expect(new_cell.char).to eq("A")
        expect(new_cell.fg_color).to eq(:white)
        expect(new_cell.bg_color).to eq(:blue)
        expect(new_cell).not_to be(cell)
      end
    end
  end
end
