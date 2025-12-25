# frozen_string_literal: true

RSpec.describe GLW::Components::Input do
  describe ".make" do
    it "creates an Input with empty events array" do
      input = described_class.make
      expect(input.events).to eq []
    end
  end

  describe "#push" do
    it "adds an event to the events array" do
      input = described_class.make

      input.push(:k_escape)

      expect(input.events).to eq [:k_escape]
    end
  end

  describe "#pop" do
    it "removes and returns the last event from the events array" do
      input = described_class.new([:k_escape])

      expect(input.pop).to eq :k_escape
      expect(input.events).to be_empty
    end
  end

  describe "#peek" do
    it "returns the last event without removing it" do
      input = described_class.new([:k_escape])

      expect(input.peek).to eq :k_escape
      expect(input.events).to eq [:k_escape]
    end
  end
end
