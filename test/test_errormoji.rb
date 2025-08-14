# frozen_string_literal: true

require "test_helper"

class TestErrormoji < Minitest::Test


  def test_that_it_has_a_version_number
    refute_nil ::Errormoji::VERSION
  end

  def test_random_emoji_returns_valid_emoji
    emoji = Errormoji.random_emoji
    assert_includes Errormoji::DEFAULT_EMOJIS, emoji
  end

  def test_global_exceptions_toggle
    Errormoji.enable_global_exceptions!
    assert Errormoji.global_exceptions?

    Errormoji.disable_global_exceptions!
    refute Errormoji.global_exceptions?
  end

  def test_custom_emojis
    custom_emojis = ["😄", "😢", "😡"]
    Errormoji.emojis = custom_emojis

    emoji = Errormoji.random_emoji
    assert_includes custom_emojis, emoji
  ensure
    Errormoji.emojis = Errormoji::DEFAULT_EMOJIS
  end

  def message_includes_emoji?(message)
    Errormoji::DEFAULT_EMOJIS.any? { |emoji| message.include?(emoji) }
  end

  def test_exception_message_format_with_emoji_and_space
    Errormoji.enable_global_exceptions!
    exception = RuntimeError.new("Test error")
    assert message_includes_emoji?(exception.message), "Exception message should include an emoji from DEFAULT_EMOJIS"
  ensure
    Errormoji.disable_global_exceptions!
  end



  def test_exception_message_without_global_exceptions
    Errormoji.disable_global_exceptions!
    exception = RuntimeError.new("Test error")
    assert_equal "Test error", exception.message
  end

  def test_empty_custom_emoji_list
    Errormoji.emojis = []
    assert_nil Errormoji.random_emoji
  ensure
    Errormoji.emojis = Errormoji::DEFAULT_EMOJIS
  end

  def test_default_emojis_are_immutable
    assert_raises(FrozenError) { Errormoji::DEFAULT_EMOJIS << "😎" }
    assert Errormoji::DEFAULT_EMOJIS.frozen?
  end

  def test_custom_emojis_are_mutable
    custom_emojis = ["😄", "😢"]
    Errormoji.emojis = custom_emojis
    Errormoji.emojis << "😎"
    assert_includes Errormoji.emojis, "😎"
  ensure
    Errormoji.emojis = Errormoji::DEFAULT_EMOJIS
  end

  def test_setting_invalid_emoji_list
    assert_raises(TypeError) { Errormoji.emojis = "not an array" }
    assert_raises(TypeError) { Errormoji.emojis = nil }
  ensure
    Errormoji.emojis = Errormoji::DEFAULT_EMOJIS
  end

  def test_random_emoji_with_non_string_elements
    Errormoji.emojis = [123, :smile, nil]
    emoji = Errormoji.random_emoji
    assert_includes [123, :smile, nil], emoji
  ensure
    Errormoji.emojis = Errormoji::DEFAULT_EMOJIS
  end

  def test_multiple_enable_disable_global_exceptions
    3.times { Errormoji.enable_global_exceptions! }
    assert Errormoji.global_exceptions?
    3.times { Errormoji.disable_global_exceptions! }
    refute Errormoji.global_exceptions?
  end
end
