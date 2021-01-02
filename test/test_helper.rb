$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "glw"
GLW.initialize_zeitwerk

require "minitest/pride"
require "minitest/autorun"
require "pry"
