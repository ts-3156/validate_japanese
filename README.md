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
validates :name, hiragana: true
```

or

```ruby
validates_japanese :name
```

## Implementation

TODO

## Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- [Report bugs](https://github.com/ts-3156/validate_japanese/issues)
- Fix bugs and [submit pull requests](https://github.com/ts-3156/validate_japanese/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features
