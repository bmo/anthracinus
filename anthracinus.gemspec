require_relative 'lib/anthracinus/version'

Gem::Specification.new do |spec|
  spec.name          = "anthracinus"
  spec.version       = Anthracinus::VERSION
  spec.authors       = ["Brian Moran"]
  spec.email         = ["brian@trucentive.com"]

  spec.summary       = %q{A library for interacting with Hawk Incentives}
  spec.description   = %q{A library for interacting with Hawk Incentives}
  spec.homepage      = "http://github.com/trucentive/anthracinus"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.5.8")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "http://github.com/trucentive/anthracinus"
  spec.metadata["changelog_uri"] = "http://github.com/trucentive/anthracinus"

  spec.add_dependency 'hashie'
  spec.add_dependency 'webmock'
  spec.add_dependency 'faraday'
  spec.add_dependency 'faraday_middleware'
  spec.add_dependency 'date'
  spec.add_dependency 'openssl'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
