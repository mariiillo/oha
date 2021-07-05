# Oha
[![Build Status](https://travis-ci.org/mariiillo/oha.svg?branch=master)](https://travis-ci.org/mariiillo/oha)

Decouple the business logic from the delivery mechanismt by using this gem.
1. Define the use case.
2. Create the UseCase class.
3. Bind the UseCase's happy path (and the not so happy ones) to what the calling object should execute in each case.
4. Profit

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

In the calling object:
```ruby
SomeUseCase.call(params) do |use_case|
    use_case.bind(:success).to(redirect_to_user)
    use_case.bind(:data_invalid).to(render_new)
    use_case.bind(:another_error).to(do_something_different)
end

def redirect_to_user
  -> (payload) do
    redirect_to user_path(payload[:user])
  end
end

def render_new
  -> (_payload) do
    render :new
  end
end

def do_something_different
  -> (_payload) do
    # ...
  end
end
```

The Use Case:
```ruby
class SomeUseCase
  include Oha

  def call(params)
    trigger(:data_invalid) if invalid_params?
    do_something
    trigger(:success, user: @user)
  rescue SomeError
    trigger(:another_error)
  end
  
  private
  
  def do_something
    @user = ...
    #...
  end
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
