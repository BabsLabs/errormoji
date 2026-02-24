# frozen_string_literal: true

require "test_helper"

class ExceptionPatchTest < Minitest::Test
  def setup
    Errormoji.enable_global_exceptions!
  end

  def teardown
    Errormoji.disable_global_exceptions!
  end

  def message_includes_emoji?(message)
    Errormoji::DEFAULT_EMOJIS.any? { |emoji| message.include?(emoji) }
  end

  def test_exception_patch_is_applied
    Errormoji.enable_global_exceptions!
    exception = RuntimeError.new("Test error")
    assert_respond_to exception, :message
    assert message_includes_emoji?(exception.message), "Exception message should include an emoji from DEFAULT_EMOJIS"
  ensure
    Errormoji.disable_global_exceptions!
  end

  def test_enable_global_exceptions_is_idempotent
    Errormoji.enable_global_exceptions!
    Errormoji.enable_global_exceptions!

    patch_count = Exception.ancestors.count { |ancestor| ancestor == Errormoji::ExceptionPatch }
    assert_equal 1, patch_count
  ensure
    Errormoji.disable_global_exceptions!
  end

  def test_disable_global_exceptions_is_safe_when_called_multiple_times
    Errormoji.enable_global_exceptions!

    Errormoji.disable_global_exceptions!
    Errormoji.disable_global_exceptions!

    refute Errormoji.global_exceptions?
  end
end
