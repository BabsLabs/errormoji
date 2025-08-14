require "test_helper"

class ExceptionPatchTest < Minitest::Test
  def setup
    Errormoji.enable_global_exceptions!
  end

  def teardown
    Errormoji.disable_global_exceptions!
  end

  def test_exception_patch_is_applied
    exception = RuntimeError.new("Test error")
    assert_respond_to exception, :message
    starts_with_emoji = Errormoji::DEFAULT_EMOJIS.any? { |emoji| exception.message.start_with?(emoji) }
    assert starts_with_emoji, "Exception message should start with an emoji from DEFAULT_EMOJIS"
  end
end
