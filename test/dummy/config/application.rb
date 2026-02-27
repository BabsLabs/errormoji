# frozen_string_literal: true

require "rails"
require "action_controller/railtie"
require "active_record"
require "logger"
require "errormoji"

module Dummy
  class Application < Rails::Application
    VERBOSE_TEST_LOGS_FLAG = "ERRORMOJI_VERBOSE_TEST_LOGS"

    config.root = File.expand_path("..", __dir__)
    config.eager_load = false
    config.secret_key_base = "errormoji-test-secret-key-base"
    config.consider_all_requests_local = true
    config.action_dispatch.show_exceptions = :none
    config.hosts << "www.example.com"

    if ENV.fetch(VERBOSE_TEST_LOGS_FLAG, "false") == "true"
      config.logger = Logger.new($stdout)
      config.log_level = :info
    else
      config.logger = Logger.new(IO::NULL)
      config.log_level = :fatal
    end
  end
end

Dummy::Application.initialize!
