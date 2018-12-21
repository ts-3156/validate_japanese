require "active_support"
require "active_record"
require "validate_japanese/version"
require "validate_japanese/validations/hiragana_validator"
require "validate_japanese/model"

ActiveSupport.on_load(:active_record) do
  include(ValidateJapanese::Model)
end

module ValidateJapanese
  class Error < StandardError; end
  # Your code goes here...
end
