# frozen_string_literal: true

require "rails/railtie"

module Errormoji
  # Provides Rails integration for Errormoji, enabling emoji decoration via configuration.
  class Railtie < ::Rails::Railtie
    config.errormoji = ActiveSupport::OrderedOptions.new
    config.errormoji.enabled = nil

    initializer "errormoji.configure" do |app|
      enabled = nil

      if app.config.respond_to?(:errormoji) && app.config.errormoji.respond_to?(:enabled)
        enabled = app.config.errormoji.enabled
      end

      enabled = app.config.errormoji_enabled if enabled.nil? && app.config.respond_to?(:errormoji_enabled)

      if enabled
        Errormoji.enable_global_exceptions!
      else
        Errormoji.disable_global_exceptions!
      end
    end
  end
end
