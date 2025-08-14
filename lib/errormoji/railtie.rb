# frozen_string_literal: true

require "rails/railtie"

module Errormoji
  # Provides Rails integration for Errormoji, enabling emoji decoration via configuration.
  class Railtie < ::Rails::Railtie
    initializer "errormoji.configure" do |app|
      if app.config.respond_to?(:errormoji_enabled)
        if app.config.errormoji_enabled
          Errormoji.enable_global_exceptions!
        else
          Errormoji.disable_global_exceptions!
        end
      end
    end
  end
end
