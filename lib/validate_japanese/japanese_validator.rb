module ActiveModel
  module Validations
    class JapaneseValidator < ::ActiveModel::EachValidator
      PREFIX = "\\A"
      SUFFIX = "\\z"
      KUHAKU = "\\s"
      CHOONPU = "ー－"
      HANKAKU_CHOONPU = "\\-"

      ALPHABET = "a-zA-Z"
      ZENKAKU_ALPHABET = "ａ-ｚＡ-Ｚ"
      HIRAGANA = "ぁ-ん"
      KATAKANA = "ァ-ン"
      HANKAKU_KANA = "ｧ-ﾝﾞﾟ"
      KANJI = "一-龠々"
      SUJI = "0-9"
      ZENKAKU_SUJI = "０-９"

      def validate_each(record, attribute, value)
        keys, regexp = build_regexp(options)

        unless value.to_s.match? regexp
          if options[:message]
            record.errors.add(attribute, options[:message])
          else
            record.errors.add(attribute, :invalid_japanese, kind: available_kind(keys))
          end
        end
      end

      private

      def build_regexp(options)
        options = options.except(:message, :choonpu, :hankaku_choonpu, :prefix, :suffix, :kuhaku)
        japanese = %i(hiragana katakana hankaku_kana kanji suji zenkaku_suji choonpu hankaku_choonpu)
        keys = []

        if options.empty?
          keys.concat japanese
        elsif options.has_key?(:only)
          keys.concat options[:only]
        elsif options.has_key?(:concat)
          keys.concat japanese
        else
          keys.concat options.select {|_, v| v}.keys
        end

        if (keys.include?(:hiragana) || keys.include?(:katakana)) && keys.exclude?(:choonpu)
          keys << :choonpu
        end
        if keys.include?(:hankaku_kana) && keys.exclude?(:hankaku_choonpu)
          keys << :hankaku_choonpu
        end

        base = keys.map(&method(:const)).join

        if options.has_key?(:concat)
          base += options[:concat].to_s
        end

        [keys, Regexp.new("#{PREFIX}[#{base}]+#{SUFFIX}")]
      end

      def const(name)
        self.class.const_get(name.upcase)
      end

      def available_kind(keys, sep = '')
        keys.reject {|k| %i(choonpu hankaku_choonpu).include?(k)}.map {|k| I18n.t("validate_japanese.#{k}")}.join(sep)
      end
    end
  end
end
