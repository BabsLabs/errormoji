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
end
