# frozen_string_literal: true

require "test_helper"
require_relative "../support/dummy_app_helper"

class RailtieExceptionsTest < ActionDispatch::IntegrationTest
  TEST_CASES = [
    { path: "/errors/bad_request", class_name: "ActionController::BadRequest" },
    { path: "/errors/unknown_format", class_name: "ActionController::UnknownFormat" },
    { path: "/errors/parameter_missing", class_name: "ActionController::ParameterMissing" },
    { path: "/errors/record_not_found", class_name: "ActiveRecord::RecordNotFound" },
    { path: "/errors/record_invalid", class_name: "ActiveRecord::RecordInvalid" },
    { path: "/errors/statement_invalid", class_name: "ActiveRecord::StatementInvalid" },
    { path: "/errors/not_implemented", class_name: "ActionController::NotImplemented" },
    { path: "/errors/invalid_authenticity_token", class_name: "ActionController::InvalidAuthenticityToken" },
    { path: "/errors/action_not_found", class_name: "AbstractController::ActionNotFound" },
    { path: "/errors/read_only_record", class_name: "ActiveRecord::ReadOnlyRecord" },
    { path: "/errors/record_not_saved", class_name: "ActiveRecord::RecordNotSaved" }
  ].freeze

  def setup
    Errormoji.disable_global_exceptions!
  end

  def teardown
    Errormoji.disable_global_exceptions!
  end

  def test_common_rails_exceptions_are_decorated_when_enabled
    Errormoji.enable_global_exceptions!

    TEST_CASES.each do |test_case|
      exception = assert_exception_for(test_case)
      assert_decorated_message(exception)
    end
  end

  def test_common_rails_exceptions_are_plain_when_disabled
    Errormoji.disable_global_exceptions!

    TEST_CASES.each do |test_case|
      exception = assert_exception_for(test_case)
      assert_plain_message(exception)
    end
  end

  def test_bad_request_can_be_exercised_through_middleware_rescue_path
    Errormoji.enable_global_exceptions!

    exception = request_with_middleware_rescue("/errors/bad_request")

    assert_response :bad_request
    refute response.successful?
    assert_decorated_message(exception)
  end

  def test_invalid_authenticity_token_can_be_exercised_through_middleware_rescue_path
    Errormoji.enable_global_exceptions!

    exception = request_with_middleware_rescue("/errors/invalid_authenticity_token")

    assert_response :unprocessable_content
    refute response.successful?
    assert_decorated_message(exception)
  end

  private

  def assert_exception_for(test_case)
    klass = resolve_constant(test_case[:class_name])
    skip "#{test_case[:class_name]} is not available in this Rails version" if klass.nil?

    assert_raises(klass) do
      get test_case[:path], env: {
        "action_dispatch.show_exceptions" => :none,
        "action_dispatch.show_detailed_exceptions" => false
      }
    end
  end

  def resolve_constant(class_name)
    class_name.split("::").reduce(Object) do |scope, name|
      return nil unless scope.const_defined?(name, false)

      scope.const_get(name, false)
    end
  end

  def request_with_middleware_rescue(path)
    with_middleware_rescue_enabled do
      get path
      exception_from_response
    end
  rescue StandardError => e
    flunk "Expected middleware-rescued response, but request raised #{e.class}: #{e.message}"
  end

  def with_middleware_rescue_enabled
    app = Rails.application
    original_show = app.env_config["action_dispatch.show_exceptions"]
    original_detailed = app.env_config["action_dispatch.show_detailed_exceptions"]

    app.env_config["action_dispatch.show_exceptions"] = :all
    app.env_config["action_dispatch.show_detailed_exceptions"] = false
    yield
  ensure
    app.env_config["action_dispatch.show_exceptions"] = original_show
    app.env_config["action_dispatch.show_detailed_exceptions"] = original_detailed
  end

  def exception_from_response
    exception = response.request.env["action_dispatch.exception"]
    refute_nil exception, "Expected middleware-rescued request to set action_dispatch.exception"
    exception
  end

  def assert_decorated_message(exception)
    message = exception.message

    assert Errormoji::DEFAULT_EMOJIS.any? { |emoji| message.include?(emoji) },
           "Expected #{exception.class.name} message to include one of DEFAULT_EMOJIS. Got: #{message.inspect}"
  end

  def assert_plain_message(exception)
    message = exception.message
    refute Errormoji::DEFAULT_EMOJIS.any? { |emoji| message.include?(emoji) },
           "Expected plain exception message without errormoji. Got: #{message.inspect}"
  end
end
