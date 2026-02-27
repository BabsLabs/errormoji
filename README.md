# Errormoji

[![Build Status](https://github.com/babslabs/errormoji/actions/workflows/ci.yml/badge.svg)](https://github.com/babslabs/errormoji/actions)

## Table of Contents
- [Supported Ruby & Rails Versions](#supported-ruby--rails-versions)
- [Installation](#installation)
- [Usage](#usage)
  - [Enabling & Disabling Emoji Decoration](#enabling--disabling-emoji-decoration)
  - [Rails Integration](#rails-integration)
- [Customization](#customization)
- [Development](#development)
- [Running Tests](#running-tests)
- [Roadmap](#roadmap)
- [Releasing a New Version](#releasing-a-new-version)
- [Contributing](#contributing)
- [License](#license)
- [Thank You for Using Errormoji!](#thank-you-for-using-errormoji)

**Example of Errormoji error messages:**
- (╯°□°）╯︵ ┻━┻ Something went wrong!
- (ಥ_ಥ) File not found!
- (ಠ益ಠ) Invalid input!

---

## Supported Ruby & Rails Versions

- **Ruby:** 3.0+
- **Rails:** 7.0+

---

## Installation

Add to your Gemfile:
```bash
bundle add errormoji
```
Or install directly:
```bash
gem install errormoji
```

---

## Usage

### Enabling & Disabling Emoji Decoration

Enable emoji decoration globally:
```ruby
require "errormoji"
Errormoji.enable_global_exceptions!
```

Disable emoji decoration:
```ruby
Errormoji.disable_global_exceptions!
```

### Rails Integration

Enable or disable Errormoji per environment in your Rails config:
```ruby
# config/environments/development.rb
Rails.application.config.errormoji.enabled = true

# config/environments/production.rb
Rails.application.config.errormoji.enabled = false
```

Legacy config is still supported:
```ruby
Rails.application.config.errormoji_enabled = true
```

**Note:**

While Errormoji makes your errors way more fun (⌐■_■), we don’t recommend enabling it in production—unless your ops team loves errormojis as much as you do! Decorated error messages might confuse your logs, monitoring tools, or that one serious developer on your team. But hey, you’re the boss: enable Errormoji wherever you want!

---

## Customization

Set your own emojis:
```ruby
Errormoji.emojis = ["😄", "😢", "😡"]
```

Add emojis to your current list:
```ruby
Errormoji.emojis << "🤖"
Errormoji.emojis += ["🔥"]
```
Build your emoji set incrementally!

---

## Development

After checking out the repo, run:
```bash
bin/setup
```
Use `bin/console` for an interactive prompt.

---

## Running Tests

Run the test suite with:
```bash
bundle exec rake test
```

Enable verbose Rails request logging for dummy-app integration tests only when needed:
```bash
bundle exec rake test:verbose
```

You can still use the environment variable directly if preferred:
```bash
ERRORMOJI_VERBOSE_TEST_LOGS=true bundle exec rake test
```

Rails integration coverage is split into two focused files:
- `test/integration/railtie_test.rb` validates Railtie config behavior.
- `test/integration/railtie_exceptions_test.rb` validates real Rails-raised exceptions from a minimal dummy app are decorated when enabled and plain when disabled.

The Rails exception integration tests boot a minimal app from `test/dummy/` and exercise representative Rails exception scenarios through both raised-exception and middleware-rescued request paths.

---

## Roadmap

- CI currently validates Rails integration against one Rails stream (latest resolvable Rails with Ruby 3.4); expand this to a Rails-version matrix.
- Add configurable severity levels (for example, map `warn`/`error`/`fatal` to different emoji sets).
- Support patching only specific exception classes instead of patching globally.

---

## Releasing a New Version

Errormoji uses [Semantic Versioning](https://semver.org/).

To release a new version:
1. Update the version number in `lib/errormoji/version.rb`.
2. Run:
    ```bash
    bundle exec rake release
    ```
   This will tag, push, and publish the gem to [rubygems.org](https://rubygems.org).

---

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/babslabs/errormoji).
Please follow our [Code of Conduct](https://github.com/babslabs/errormoji/blob/main/CODE_OF_CONDUCT.md).

---

## License

Open source under the [MIT License](https://opensource.org/licenses/MIT).

---

## Thank You for Using Errormoji!

We appreciate you bringing a little more fun to your error messages. Happy coding!

(╯°□°）╯︵ ┻━┻
