require "test_helper"

class GLWTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::GLW::VERSION
  end
end
