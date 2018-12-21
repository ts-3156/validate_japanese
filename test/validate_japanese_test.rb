require_relative "test_helper"

class ValidateJapaneseTest < Minitest::Test
  def setup
    User.delete_all
    Member.delete_all
  end

  def test_custom_validators
    assert User.new(name: 'ひらがな').valid?
    assert !User.new(name: 'hiragana').valid?
  end

  def test_validates_with
    assert Member.new(name: 'ひらがな').valid?
    assert !Member.new(name: 'hiragana').valid?
  end
end
