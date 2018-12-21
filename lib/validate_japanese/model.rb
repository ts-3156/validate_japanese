require "active_support/concern"

module ValidateJapanese
  module Model
    extend ActiveSupport::Concern

    class_methods do
      def validates_japanese(*attr_names)
        validates_with ::ActiveModel::Validations::HiraganaValidator, _merge_attributes(attr_names)
      end
    end
  end
end
