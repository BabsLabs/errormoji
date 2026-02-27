# frozen_string_literal: true

require_relative "errormoji/version"
require_relative "errormoji/exception_patch"

if Object.const_defined?(:Rails)
  require "rails/railtie"
  require_relative "errormoji/railtie"
end

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
      raise TypeError, "Errormoji.emojis must be an Array" unless list.is_a?(Array)

      @emojis = list
    end

    attr_reader :emojis

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
  end
end
