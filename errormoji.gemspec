# frozen_string_literal: true

require_relative "lib/errormoji/version"

Gem::Specification.new do |spec|
  spec.name        = "errormoji"
  spec.version     = Errormoji::VERSION
  spec.summary     = "Add fun emojis to exception messages"
  spec.description = "Errormoji decorates exception messages with fun ASCII emojis to make debugging more enjoyable."
  spec.authors     = ["Your Name"]
  spec.email       = ["your_email@example.com"]
  spec.files       = Dir["lib/**/*", "bin/*", "test/**/*", "sig/**/*"]
  spec.homepage    = "https://github.com/your_username/errormoji"
  spec.license     = "MIT"
  spec.name = "errormoji"
  spec.version = Errormoji::VERSION
  spec.authors = ["BabsLabs"]
  spec.email = ["brian5bower@gmail.com"]

  spec.summary = "A Ruby gem that increases happiness but supplimenting error messages with ascii emojis."
  spec.description = "A Ruby gem that increases happiness but supplimenting error messages with ascii emojis"
  # spec.homepage = "TODO: Put your gem's website or public repo URL here."
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7"
  spec.files = ["lib/errormoji.rb", "lib/errormoji/exception_patch.rb", "lib/errormoji/version.rb"]

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  # spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  # gemspec = File.basename(__FILE__)
  # spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
  #   ls.readlines("\x0", chomp: true).reject do |f|
  #     (f == gemspec) ||
  #       f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
  #   end
  # end
  # spec.bindir = "exe"
  # spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  # spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
