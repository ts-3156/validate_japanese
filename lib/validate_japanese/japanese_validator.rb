module ActiveModel
  module Validations
    class JapaneseValidator < ::ActiveModel::EachValidator
      PREFIX = "\\A"
      SUFFIX = "\\z"
      KUHAKU = "\\s"
      CHOONPU = "ー－"

      ALPHABET = "a-zA-Z"
      ZENKAKU_ALPHABET = "ａ-ｚＡ-Ｚ"
      HIRAGANA = "ぁ-ん"
      KATAKANA = "ァ-ン"
      HANKAKU_KANA = "ｧ-ﾝﾞﾟ"
      KANJI = "一-龠々"
      SUJI = "0-9"
      ZENKAKU_SUJI = "０-９"

      def validate_each(record, attribute, value)
        unless value.to_s.match? build_regexp(options)
          record.errors.add(attribute, options[:message] || :invalid)
        end
      end

      private

      def build_regexp(options)
        options = options.except(:message)
        japanese = %i(hiragana katakana hankaku_kana kanji suji zenkaku_suji choonpu)
        keys = []

        if options.empty?
          keys.concat japanese
        elsif options.has_key?(:only)
          keys.concat options[:only]
        elsif options.has_key?(:concat)
          keys.concat japanese
          keys.concat options[:concat].map(&:to_sym).except(*japanese)
        else
          keys.concat options.select {|_, v| v}.keys
        end

        Regexp.new("#{PREFIX}[#{keys.map(&method(:const)).join}]+#{SUFFIX}")
      end

      def const(name)
        self.class.const_get(name.upcase)
      end
    end
  end
end
