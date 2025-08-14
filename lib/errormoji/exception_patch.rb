# frozen_string_literal: true

module Errormoji
  # The Errormoji::ExceptionPatch module provides functionality to override the
  # Exception#message method. When global exceptions are enabled, this module
  # prepends a random emoji to exception messages, adding a touch of fun and
  # personality to error handling.
  module ExceptionPatch
    # Override Exception#message to prefix with an emoji when enabled
    def message
        base_msg = super
        if Errormoji.global_exceptions?
            "#{Errormoji.random_emoji} #{base_msg}"
        else
            base_msg
        end
    end
  end
end
