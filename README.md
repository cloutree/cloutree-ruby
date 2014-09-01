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
    CC.upload(filename) #=> will return link for uploaded file
    CC.result           #=> will return link for last uploaded file
