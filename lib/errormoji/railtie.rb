# frozen_string_literal: true

require "rails/railtie"

module Errormoji
  class Railtie < ::Rails::Railtie
    # Allow users to opt in/out via config.errormoji_enabled in environment files
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
