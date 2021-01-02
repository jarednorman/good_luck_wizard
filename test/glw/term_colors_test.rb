module GLW
  class TermColorsTest < Minitest::Test
    def test_colors
      fake_curses = Minitest::Mock.new
      fake_curses.expect(:init_pair, nil, [1, 89, 233])
      fake_curses.expect(:color_pair, 256, [1])

      c = TermColors.new(fake_curses)

      assert_equal 256, c[89, 233]

      fake_curses.expect(:init_pair, nil, [2, 90, 234])
      fake_curses.expect(:color_pair, 256, [2])

      assert_equal 256, c[90, 234]
      assert_equal 256, c[90, 234]
    end
  end
end
