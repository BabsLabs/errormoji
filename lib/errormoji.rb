# frozen_string_literal: true

require_relative "errormoji/version"
require_relative "errormoji/exception_patch"
require "rails/railtie" if Object.const_defined?(:Rails) && Rails.const_defined?(:Railtie)

# The Errormoji module is the core of the gem, providing methods to decorate
# exception messages with fun ASCII emojis. It allows users to enable or disable
# global exception decoration and customize the emoji set to suit their preferences.
module Errormoji
  class Error < StandardError; end

  DEFAULT_EMOJIS = [
    # Angry / frustrated
    "(╯°□°）╯︵ ┻━┻",
    "(╯°益°)╯彡┻━┻",
    "(ノಠ益ಠ)ノ彡┻━┻",
    "(ಠ益ಠ)",
    "ლ(ಠ益ಠ)ლ",
    "ಠ益ಠ",
    "(งಠ益ಠ)ง",
    "(ง •̀_•́)ง",
    "(ง'̀-'́)ง",
    # Disapproval / annoyance
    "(ಠ_ಠ)",
    "¬_¬",
    # Neutral / confused
    "¯\\_(ツ)_/¯",
    "(•_•)",
    "¯\\(°_o)/¯",
    # Surprised
    "(ʘᗩʘ′)",
    # Sad / crying
    "(ಥ_ಥ)",
    "(ಥ﹏ಥ)",
    "｡•́︿•̀｡",
    "(✖╭╮✖)",
    "(ಥ﹏ಥ)",
    "(╥﹏╥)",
    "(T_T)",
    "(；△；)",
    "(╥_╥)",
    "(；д；)",
    "(ಥ⌓ಥ)",
    # Happy / cool
    "(ᵔᴥᵔ)",
    "(⌐■_■)",
    "(≧◡≦)",
    "(ಥ◡ಥ)"
  ].freeze

  @emojis = DEFAULT_EMOJIS.dup
  @global_exceptions = false
  @exception_patched = false

  class << self
    # Only allow assignment of an Array for emojis
    def emojis=(list)
      unless list.is_a?(Array)
        raise TypeError, "Errormoji.emojis must be an Array"
      end
      @emojis = list
    end

    def emojis
      @emojis
    end

    def random_emoji
      @emojis.sample
    end

    def global_exceptions?
      @global_exceptions
    end

    def enable_global_exceptions!
      @global_exceptions = true
      return if @exception_patched

      Exception.prepend ExceptionPatch # patch Exception#message
      @exception_patched = true
    end

    # Disable global decoration of Exception messages
    def disable_global_exceptions!
      @global_exceptions = false
    end

    # Railtie for Rails integration
    if Object.const_defined?(:Rails) && Rails.const_defined?(:Railtie)
      class Railtie < Rails::Railtie
        initializer "errormoji.configure_rails_initialization" do |app|
          Rails.logger.info "Errormoji Railtie initializer executed"
          if app.config.respond_to?(:errormoji_enabled) && app.config.errormoji_enabled
            Errormoji.enable_global_exceptions!
          end
        end
      end
    end
  end
end
