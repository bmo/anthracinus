# Anthracinus

Welcome to your new gem! 
A Gem to talk with Blackhawk Network's Hawk Marketplace.

To experiment with that code, run `bin/console` for an interactive prompt.

The Blackhawk bird is Buteogallus anthracinus, hence the neame

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'anthracinus'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install anthracinus

## Usage

Obtain a P12 certificate/key and associated password from Blackhawk Incentives, along with a merchant id.

Call the gem like this:

```ruby
    api = Anthracinus::Client.new(merchant_id:m_id,
                                  client_certificate_filename: '<your_filename.p12>',
                                  client_certificate_password: 'some-password-string',
                                  )
```
and then to get catalog:
```
    catalog_json = api.catalog("95001375")
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bmo/anthracinus.

