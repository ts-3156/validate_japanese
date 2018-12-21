module ActiveModel
  module Validations
    class HiraganaValidator < ::ActiveModel::EachValidator
      def validate_each(record, attribute, value)
        unless value =~ /\A[ぁ-んー－]+\z/
          record.errors.add(attribute, options[:message] || :invalid)
        end
      end
    end
  end
end
