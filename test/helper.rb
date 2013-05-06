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


unless ENV['NO_MOCKING']
  require 'webmock/test_unit'
end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'insound_api'

class Test::Unit::TestCase

  def mocking?
    !ENV['NO_MOCKING']
  end

  def setup_credentials
    if mocking?
      setup_test_credentials
    else
      setup_credentials_from_config
      # give their webserver a little break
      sleep(1) unless mocking?
    end
  end

  def setup_test_credentials
    InsoundApi.setup do |config|
      config.affiliate_id = 42
      config.api_password = 'fart'
    end
  end


  def setup_credentials_from_config
    h = YAML.load_file('config.yml')
    InsoundApi.setup do |config|
      config.affiliate_id = h['affiliate_id']
      config.api_password = h['api_password']
    end
  end

  def mock(name, query_string)
    return unless mocking?

    dir = File.dirname(__FILE__) + "/webmock/#{name}.xml"
    file = File.open(dir)
    body = file.read
    url = "https://www.insound.com/ws/affiliate/#{query_string}&id=42&password=fart"
    stub_request(:get, url).to_return(:status => 200, :body => body)
  end

  def teardown
    InsoundApi.instance_variable_set(:@config, nil)
    WebMock.reset! if mocking?
  end

end
