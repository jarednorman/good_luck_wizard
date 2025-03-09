RSpec.describe GLW::Random do
  it "generates random numbers" do
    r = GLW::Random.new(1234567)

    expect(r.integer).to eq(3540625527)
    expect(r.integer).to eq(2750739987)
    expect(r.integer).to eq(4037983143)
    expect(r.integer).to eq(1993361440)
    expect(r.integer).to eq(3809424708)

    expect(r.float).to eq(0.41792595060542226)
    expect(r.float).to eq(0.45332382223568857)
    expect(r.float).to eq(0.14579462399706244)
  end

  it "samples" do
    r = GLW::Random.new(1234567)
    c = [:foo, :bar, :baz]

    expect(r.sample(c)).to eq(:foo)
    expect(r.sample(c)).to eq(:foo)
    expect(r.sample(c)).to eq(:foo)
    expect(r.sample(c)).to eq(:bar)
    expect(r.sample(c)).to eq(:foo)
    expect(r.sample(c)).to eq(:baz)
  end
end
