# frozen_string_literal: true

RSpec.describe GLW::Universe do
  let(:universe) { described_class.new }

  describe "#singletons" do
    subject { universe.singletons }

    let(:singleton_class) {
      Data.define(:value) do
        def self.make
          new(value: 42)
        end
      end
    }

    it "instantiates and memoizes singletons" do
      singleton = universe.singletons[singleton_class]

      expect(singleton).to eq singleton_class.new(value: 42)
      expect(universe.singletons[singleton_class]).to be singleton
    end
  end
end
