
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "glw/version"

Gem::Specification.new do |spec|
  spec.name          = "good_luck_wizard"
  spec.version       = GLW::VERSION
  spec.authors       = ["Jared Norman"]
  spec.email         = ["jared@super.gd"]

  spec.summary       = "An unfinished terminal-based roguelike game"
  spec.description   = spec.summary
  spec.homepage      = "http://github.com/jarednorman/glw"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "curses", "~> 1.4.0"
  spec.add_dependency "zeitwerk", "~> 2.4"

  spec.add_development_dependency "bundler", "~> 2.1"
  spec.add_development_dependency "rake", ["~> 12.3", ">= 12.3.3"]
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-stack_explorer"
end
