# Validate Japanese

[![Build Status](https://travis-ci.org/ts-3156/validate_japanese.svg?branch=master)](https://travis-ci.org/ts-3156/validate_japanese)
[![Gem Version](https://badge.fury.io/rb/validate_japanese.svg)](https://badge.fury.io/rb/validate_japanese)

This gem adds the capability of validating Japanese to ActiveRecord. :tada:

## Getting Started

Add this line to your application’s Gemfile:

```ruby
gem 'validate_japanese'
```

Add a validation rule to your model:

```ruby
class User < ApplicationRecord
  validates :name, japanese: true
end
```

I18n error message:

```ruby
User.new(name: 'invalid name').tap(&:valid?)
# => Name に使える文字はひらがなカタカナ半角カナ漢字数字全角数字です。
```

## Usage

```ruby
# hiragana katakana hankaku_kana kanji suji zenkaku_suji "ー－" + "-"
validates :name, japanese: true

user.errors.full_messages
# => Name に使える文字はひらがなカタカナ半角カナ漢字数字全角数字です。
```

```ruby
# hiragana "ぁ-ん" + "ー－"
validates :name, japanese: {hiragana: true}

user.errors.full_messages
# => Name に使える文字はひらがなです。
```

```ruby
# katakana "ァ-ン" + "ー－"
validates :name, japanese: {katakana: true}

user.errors.full_messages
# => Name に使える文字はカタカナです。
```

```ruby
# hankaku_kana "ｧ-ﾝﾞﾟ" + "-"
validates :name, japanese: {hankaku_kana: true}

user.errors.full_messages
# => Name に使える文字は半角カナです。
```

```ruby
# kanji "一-龠々"
validates :name, japanese: {kanji: true}

user.errors.full_messages
# => Name に使える文字は漢字です。
```

```ruby
# suji "0-9"
validates :name, japanese: {suji: true}

user.errors.full_messages
# => Name に使える文字は数字です。
```

```ruby
# zenkaku_suji "０-９"
validates :name, japanese: {zenkaku_suji: true}

user.errors.full_messages
# => Name に使える文字は全角数字です。
```

```ruby
# hiragana katakana "ぁ-ん" + "ァ-ン" + "ー－"
validates :name, japanese: {only: %i(hiragana katakana)}

user.errors.full_messages
# => Name に使える文字はひらがなカタカナです。
```

```ruby
# japanese "、。"
validates :name, japanese: {concat: '、。'}

user.errors.full_messages
# => Name に使える文字はひらがなカタカナ半角カナ漢字数字全角数字、。です。
```

## Implementation

TODO

## Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- [Report bugs](https://github.com/ts-3156/validate_japanese/issues)
- Fix bugs and [submit pull requests](https://github.com/ts-3156/validate_japanese/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features
