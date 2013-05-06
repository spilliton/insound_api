# insound_api


[![Build Status](https://secure.travis-ci.org/spilliton/insound_api.png?branch=master)](http://travis-ci.org/spilliton/insound_api)
[![Code Climate](https://codeclimate.com/github/spilliton/insound_api.png)](https://codeclimate.com/github/spilliton/insound_api)

A ruby gem for accessing the insound.com Web Service API for affiliates

## Install

``` ruby
# Add the following to you Gemfile
gem 'insound_api'

# Update your bundle
bundle install
```

## Usage

You will need to setup insound_api to use your credentials.  If you are using rails, a good place to do this is in a initializer:

``` ruby
# /config/initializers/insound_api.rb

InsoundApi.setup do |config|
  config.affiliate_id = 42
  config.api_password = 'my_password'
end

```

