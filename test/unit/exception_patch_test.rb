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
    assert_includes Errormoji::DEFAULT_EMOJIS, exception.message.split.first, "Exception message should start with an emoji from DEFAULT_EMOJIS"
  end
end
