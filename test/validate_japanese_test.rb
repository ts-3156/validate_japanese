require_relative "test_helper"

class ValidateJapaneseTest < Minitest::Test
  def setup
    User.delete_all
    User.clear_validators!
  end

  def test_japanese
    User.send(:validates, :name, japanese: true)
    ok('ひらがなカタカナﾊﾝｶｸｶﾅ漢字012０１２ー－ｰ-')
    ng('alphabet')
  end

  def test_hiragana
    User.send(:validates, :name, japanese: {hiragana: true})
    ok('ひらがなー－')
    ng('カタカナ')
  end

  def test_katakana
    User.send(:validates, :name, japanese: {katakana: true})
    ok('カタカナー－')
    ng('ひらがな')
  end

  def test_hankaku_kana
    User.send(:validates, :name, japanese: {hankaku_kana: true})
    ok('ﾊﾝｶｸｶﾅｰ-')
    ng('カタカナ')
  end

  def test_kanji
    User.send(:validates, :name, japanese: {kanji: true})
    ok('漢字々')
    ng('ひらがな')
  end

  def test_suji
    User.send(:validates, :name, japanese: {suji: true})
    ok('01234')
    ng('０１２３４')
  end

  def test_zenkaku_suji
    User.send(:validates, :name, japanese: {zenkaku_suji: true})
    ok('０１２３４')
    ng('01234')
  end

  def test_only
    User.send(:validates, :name, japanese: {only: %i(hiragana katakana)})
    ok('ひらがなとカタカナ')
    ng('ひらがなと漢字')
  end

  def test_concat
    User.send(:validates, :name, japanese: {concat: '、。'})
    ok('今日は、晴れです。')
    ng('今日は,晴れです.')
  end

  private

  def ok(value)
    assert User.new(name: value).tap(&:valid?).errors[:name].empty?
  end

  def ng(value)
    assert !User.new(name: value).tap(&:valid?).errors[:name].empty?
  end
end
