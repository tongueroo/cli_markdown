lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "cli_markdown/version"

Gem::Specification.new do |spec|
  spec.name          = "cli_markdown"
  spec.version       = CliMarkdown::VERSION
  spec.authors       = ["Tung Nguyen"]
  spec.email         = ["tongueroo@gmail.com"]

  spec.summary       = "Generate markdown docs from cli docs"
  spec.homepage      = "https://github.com/tongueroo/cli_markdown"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "lono"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
