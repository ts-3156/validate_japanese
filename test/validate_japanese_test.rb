require_relative "test_helper"

class ValidateJapaneseTest < Minitest::Test
  def setup
    User.delete_all
    User.clear_validators!
  end

  def test_japanese
    setting(true)
    ok('ひらがなカタカナﾊﾝｶｸｶﾅ漢字012０１２ー－ｰ-')
    ng('alphabet')
  end

  def test_hiragana
    setting(hiragana: true)
    ok('ひらがなー－')
    ng('カタカナ')
  end

  def test_katakana
    setting(katakana: true)
    ok('カタカナー－')
    ng('ひらがな')
  end

  def test_hankaku_kana
    setting(hankaku_kana: true)
    ok('ﾊﾝｶｸｶﾅｰ-')
    ng('カタカナ')
  end

  def test_kanji
    setting(kanji: true)
    ok('漢字々')
    ng('ひらがな')
  end

  def test_suji
    setting(suji: true)
    ok('01234')
    ng('０１２３４')
  end

  def test_zenkaku_suji
    setting(zenkaku_suji: true)
    ok('０１２３４')
    ng('01234')
  end

  def test_only
    setting(only: %i(hiragana katakana))
    ok('ひらがなとカタカナ')
    ng('ひらがなと漢字')
  end

  def test_concat
    setting(concat: '、。')
    ok('今日は、晴れです。')
    ng('今日は,晴れです.')
  end

  private

  def setting(value)
    User.send(:validates, :name, japanese: value)
  end

  def ok(value)
    assert User.new(name: value).tap(&:valid?).errors[:name].empty?
  end

  def ng(value)
    assert !User.new(name: value).tap(&:valid?).errors[:name].empty?
  end
end
