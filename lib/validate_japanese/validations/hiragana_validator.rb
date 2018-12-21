module ActiveModel
  module Validations
    class HiraganaValidator < ::ActiveModel::EachValidator
      def validate_each(record, attribute, value)
        unless value =~ ::ValidateJapanese::Formats::HIRAGANA
          record.errors.add(attribute, options[:message] || :invalid)
        end
      end
    end
  end
end
