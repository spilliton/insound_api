# insound_api


[![Build Status](https://secure.travis-ci.org/spilliton/insound_api.png?branch=master)](http://travis-ci.org/spilliton/insound_api)
[![Code Climate](https://codeclimate.com/github/spilliton/insound_api.png)](https://codeclimate.com/github/spilliton/insound_api)

A ruby gem for accessing the [insound.com Web Service API for affiliates][api_docs].


## Install

``` ruby
# Add the following to you Gemfile
gem 'insound_api'

# Update your bundle
bundle install
```

## Setup

You will need to setup insound_api to use your credentials.  If you are using rails, a good place to do this is in a initializer:

``` ruby
# /config/initializers/insound_api.rb
InsoundApi.setup do |config|
  config.affiliate_id = 42
  config.api_password = 'my_password'
end
```

## Usage

Currently the API only supports searches and you must provide an artist param.  There are some optional params (title, maxresults, format) you can find in their [API Doc][api_docs].  The results contain some metadata about the search as well as two arrays of resulting products and artists:

``` ruby
results = InsoundApi.search(:artist => "Nofx", :maxresults => 50)
results.artists_total
 => 1
results.products_total
 => 36
artist = results.artists.first
artist.name
 => "NOFX"
product = results.products.first
product.title
=> "I Heard They Suck Live!"
```

Products have the following attributes:  url, id, title, artist_name, format

and Artists have: url, id, name



[api_docs]: https://www.insound.com/affiliate/webservices.php
