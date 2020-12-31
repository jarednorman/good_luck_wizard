require "test_helper"

module GLW
  class RandomTest < Minitest::Test
    def test_generating_random_numbers
      r = GLW::Random.new(1234567)

      assert_equal 3540625527, r.integer
      assert_equal 2750739987, r.integer
      assert_equal 4037983143, r.integer
      assert_equal 1993361440, r.integer
      assert_equal 3809424708, r.integer

      assert_equal 0.41792595060542226, r.float
      assert_equal 0.45332382223568857, r.float
      assert_equal 0.14579462399706244, r.float
    end

    def test_sampling
      r = GLW::Random.new(1234567)
      c = [:foo, :bar, :baz]

      assert_equal :foo, r.sample(c)
      assert_equal :foo, r.sample(c)
      assert_equal :foo, r.sample(c)
      assert_equal :bar, r.sample(c)
      assert_equal :foo, r.sample(c)
      assert_equal :baz, r.sample(c)
    end
  end
end
