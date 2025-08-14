# Errormoji

[![Build Status](https://github.com/your_username/errormoji/actions/workflows/ci.yml/badge.svg)](https://github.com/your_username/errormoji/actions)

Errormoji is a Ruby gem that adds a touch of fun to your error messages by decorating them with ASCII emojis. Whether you're debugging or just want to make your errors more engaging, Errormoji has you covered!



## Installation

To install Errormoji, add it to your application's Gemfile by executing:

```bash
bundle add errormoji
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install errormoji
```

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add UPDATE_WITH_YOUR_GEM_NAME_IMMEDIATELY_AFTER_RELEASE_TO_RUBYGEMS_ORG
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install UPDATE_WITH_YOUR_GEM_NAME_IMMEDIATELY_AFTER_RELEASE_TO_RUBYGEMS_ORG
```

## Usage

To enable emoji decoration for all exceptions globally, or on a per-environment basis in Rails:

### Enabling Globally
```ruby
require "errormoji"

Errormoji.enable_global_exceptions!

raise "Oops, something went wrong!"
# Output: (╯°□°）╯︵ ┻━┻ Oops, something went wrong!
```

### Enabling in Rails (Per-Environment)
In a Rails app, you can enable `Errormoji` on a per-environment basis by adding a configuration line to your environment files:

```ruby
# config/environments/development.rb
Rails.application.config.errormoji_enabled = true
```

Then, `Errormoji` will automatically enable global exception decoration based on this configuration. For example, you can enable it in `development` and `test` environments but leave it disabled in `production`:

```ruby
# config/environments/test.rb
Rails.application.config.errormoji_enabled = true

# config/environments/production.rb
Rails.application.config.errormoji_enabled = false
```

To disable emoji decoration:

```ruby
Errormoji.disable_global_exceptions!
```

### Customization

You can customize the emojis used by Errormoji:

```ruby
Errormoji.emojis = ["😄", "😢", "😡"]
```

This will replace the default emoji set with your custom list.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment with the gem.

To install this gem onto your local machine, run:

```bash
bundle exec rake install
```

To release a new version, update the version number in `version.rb`, and then run:

```bash
bundle exec rake release
```

This will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yourusername/errormoji. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/yourusername/errormoji/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Errormoji project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/errormoji/blob/main/CODE_OF_CONDUCT.md).
