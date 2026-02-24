# frozen_string_literal: true

require "test_helper"
require "rails"
require "errormoji/railtie"

class RailtieTest < Minitest::Test
  FakeApp = Struct.new(:config)
  LegacyOnlyApp = Struct.new(:config)

  class FakeConfig
    attr_accessor :errormoji, :errormoji_enabled
  end

  class LegacyOnlyConfig
    attr_accessor :errormoji_enabled
  end

  def setup
    Errormoji.disable_global_exceptions!
  end

  def teardown
    Errormoji.disable_global_exceptions!
  end

  def test_namespaced_config_enables_errormoji
    app = build_app(errormoji_enabled: true)

    run_railtie_initializer(app)

    assert Errormoji.global_exceptions?
  end

  def test_namespaced_config_disables_errormoji
    app = build_app(errormoji_enabled: false)

    run_railtie_initializer(app)

    refute Errormoji.global_exceptions?
  end

  def test_legacy_config_enables_when_namespaced_is_nil
    app = build_app(errormoji_enabled: nil, legacy_enabled: true)

    run_railtie_initializer(app)

    assert Errormoji.global_exceptions?
  end

  def test_namespaced_config_takes_precedence_over_legacy_config
    app = build_app(errormoji_enabled: false, legacy_enabled: true)

    run_railtie_initializer(app)

    refute Errormoji.global_exceptions?
  end

  def test_defaults_to_disabled_when_no_config_is_set
    app = build_app

    run_railtie_initializer(app)

    refute Errormoji.global_exceptions?
  end

  def test_defaults_to_disabled_when_namespaced_config_is_missing
    config = LegacyOnlyConfig.new
    config.errormoji_enabled = nil
    app = LegacyOnlyApp.new(config)

    run_railtie_initializer(app)

    refute Errormoji.global_exceptions?
  end

  def test_defaults_to_disabled_when_namespaced_config_has_no_enabled
    app = build_app
    app.config.errormoji = Object.new

    run_railtie_initializer(app)

    refute Errormoji.global_exceptions?
  end

  def test_truthy_non_boolean_values_enable_errormoji
    app = build_app(errormoji_enabled: "true")

    run_railtie_initializer(app)

    assert Errormoji.global_exceptions?
  end

  def test_railtie_has_single_errormoji_configure_initializer
    matching_initializers = Errormoji::Railtie.initializers.select { |item| item.name == "errormoji.configure" }

    assert_equal 1, matching_initializers.size
  end

  private

  def build_app(errormoji_enabled: nil, legacy_enabled: nil)
    config = FakeConfig.new
    config.errormoji = ActiveSupport::OrderedOptions.new
    config.errormoji.enabled = errormoji_enabled
    config.errormoji_enabled = legacy_enabled

    FakeApp.new(config)
  end

  def run_railtie_initializer(app)
    initializer = Errormoji::Railtie.initializers.find { |item| item.name == "errormoji.configure" }

    refute_nil initializer
    initializer.block.call(app)
  end
end
