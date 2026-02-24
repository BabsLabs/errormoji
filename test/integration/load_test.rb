# frozen_string_literal: true

require "test_helper"
require "open3"
require "rbconfig"

class LoadTest < Minitest::Test
  def test_require_errormoji_without_rails_loaded
    script = <<~RUBY
      $LOAD_PATH.unshift File.expand_path("lib", __dir__)
      require "errormoji"
      abort "Errormoji::Railtie unexpectedly loaded" if defined?(Errormoji::Railtie)
      puts "ok"
    RUBY

    stdout, stderr, status = Open3.capture3(RbConfig.ruby, "-e", script, chdir: File.expand_path("../..", __dir__))

    assert status.success?, "Expected success, got stderr: #{stderr}"
    assert_equal "ok\n", stdout
  end

  def test_require_errormoji_with_rails_loaded
    script = <<~RUBY
      $LOAD_PATH.unshift File.expand_path("lib", __dir__)
      require "rails"
      require "errormoji"
      abort "Errormoji::Railtie not loaded" unless defined?(Errormoji::Railtie)
      puts "ok"
    RUBY

    stdout, stderr, status = Open3.capture3(RbConfig.ruby, "-e", script, chdir: File.expand_path("../..", __dir__))

    assert status.success?, "Expected success, got stderr: #{stderr}"
    assert_equal "ok\n", stdout
  end
end
