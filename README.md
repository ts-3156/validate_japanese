# Validate Japanese

[![Build Status](https://travis-ci.org/ts-3156/validate_japanese.svg?branch=master)](https://travis-ci.org/ts-3156/validate_japanese)
[![Gem Version](https://badge.fury.io/rb/validate_japanese.svg)](https://badge.fury.io/rb/validate_japanese)

This gem adds the capability of validating Japanese to ActiveRecord. :tada:

## Getting Started

Add this line to your application’s Gemfile:

```ruby
gem 'validate_japanese'
```

Add a validation rule to your model.

```ruby
validates :name, japanese: true
```

## Usage

```ruby
class User < ApplicationRecord
  # hiragana katakana hankaku_kana kanji suji zenkaku_suji choonpu
  validates :name, japanese: true

  # hiragana "ぁ-ん" + "ー－"
  validates :name, japanese: {hiragana: true}

  # katakana "ァ-ン" + "ー－"
  validates :name, japanese: {katakana: true}

  # hankaku_kana "ｧ-ﾝﾞﾟ" + "-"
  validates :name, japanese: {hankaku_kana: true}

  # kanji "一-龠々"
  validates :name, japanese: {kanji: true}

  # suji "0-9"
  validates :name, japanese: {suji: true}

  # zenkaku_suji "０-９"
  validates :name, japanese: {zenkaku_suji: true}

  # hiragana katakana "ぁ-ん" + "ァ-ン" + "ー－"
  validates :name, japanese: {only: %i(hiragana katakana)}

  # japanese + "、。"
  validates :name, japanese: {concat: '、。'}
end
```

## Implementation

TODO

## Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- [Report bugs](https://github.com/ts-3156/validate_japanese/issues)
- Fix bugs and [submit pull requests](https://github.com/ts-3156/validate_japanese/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features
