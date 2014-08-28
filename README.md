# Cloutree

Add this line to your application's Gemfile:

    gem 'cloutree'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cloutree

## Usage

    CC.configure(
      app_key: YOUR_APP_KEY,
      app_secret: YOUR_APP_SECRET
    )
    client = CC.instance
    client.upload(filename)

## Contributing

1. Fork it ( http://github.com/<my-github-username>/cloutree/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
