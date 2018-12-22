require "active_support"
require "active_record"
require 'active_support/i18n'
I18n.load_path += Dir[File.dirname(__FILE__) + "/locale/*.yml"]
require "validate_japanese/version"
require "validate_japanese/japanese_validator"

module ValidateJapanese
  class Error < StandardError; end
  # Your code goes here...
end
