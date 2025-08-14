# frozen_string_literal: true

require_relative "lib/errormoji/version"

Gem::Specification.new do |spec|
  spec.name        = "errormoji"
  spec.version     = Errormoji::VERSION
  spec.summary     = "A Ruby gem that increases happiness by supplementing error messages with ASCII emojis."
  spec.description = "Errormoji decorates exception messages with fun ASCII emojis to make debugging more enjoyable."
  spec.authors     = ["BabsLabs"]
  spec.email       = ["brian5bower@gmail.com"]
  spec.files       = Dir["lib/**/*", "bin/*", "test/**/*", "sig/**/*"]
  spec.homepage    = "https://github.com/babslabs/errormoji"
  spec.license     = "MIT"
  spec.required_ruby_version = ">= 2.7"

  # Uncomment to add development dependencies
  # spec.add_development_dependency "rails", ">= 6.0", "< 8.0"

  # Uncomment and update metadata as needed
  # spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = "https://github.com/babslabs/errormoji"
  # spec.metadata["changelog_uri"] = "https://github.com/babslabs/errormoji/blob/main/CHANGELOG.md"
end
