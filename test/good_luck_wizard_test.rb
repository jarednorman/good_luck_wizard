require "test_helper"

class GoodLuckWizardTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::GoodLuckWizard::VERSION
  end
end
