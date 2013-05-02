require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'test/unit'
require 'shoulda'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'insound_api'

class Test::Unit::TestCase

  def setup_bad_credentials
    InsoundApi.setup do |config|
      config.affiliate_id = 2342423
      config.api_password = 'yyyyyy'
    end
  end

  def setup_credentials_from_config
    h = YAML.load_file('config.yml')
    puts "h: #{h.inspect}"

    InsoundApi.setup do |config|
      config.affiliate_id = h['affiliate_id']
      config.api_password = h['api_password']
    end
  end

  def teardown
    InsoundApi.instance_variable_set(:@config, nil)
  end

end
