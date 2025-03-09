# frozen_string_literal: true

require "glw"
# FIXME: This shouldn't really be necessary. I don't know why I coded it like
# this.
GLW.initialize_zeitwerk

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
