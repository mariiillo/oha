# Oha
[![Build Status](https://travis-ci.org/mariiillo/oha.svg?branch=master)](https://travis-ci.org/mariiillo/oha)

This gem standarize how you'll interact with Service Objects...the use of this gem will allow you to decouple your business logic from your delivery mechanism.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'oha'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install oha

## Usage

```ruby
ServiceObject.call(params) do
    on(:success) { <something happens> }
    on(:data_invaid) { <something happens> }
    on(:another_error) { <something happens> }
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mariiillo/oha. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Oha project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/oha/blob/master/CODE_OF_CONDUCT.md).
