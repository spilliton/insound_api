$:.unshift '.';require File.dirname(__FILE__) + '/helper'

module InsoundApi
  class RequestTest < Test::Unit::TestCase

    context 'with invalid credentials' do
      setup do
        setup_bad_credentials
      end

      should 'raise errors on response' do
        ex = assert_raise(RequestException) { Request.get(:artist => "townes van zandt") }
        assert ex.message =~ /Invalid account information/i
      end

      should 'correctly build_url' do
        request = Request.new(:artist => "townes van zandt")
        assert_equal 'https://www.insound.com/ws/affiliate/?id=2342423&password=yyyyyy&artist=townes%20van%20zandt', request.build_url
      end

    end

    context 'with valid credentials' do
      setup do
        setup_credentials_from_config
      end

      should 'raise RequestException if artist not provided' do
        ex = assert_raise(RequestException) { Request.get }
        assert_equal ":artist is a required param for any request", ex.message
      end

      should 'raise RequestException if invalid format provided' do
        ex = assert_raise(RequestException) { Request.get(:artist => 'blah', :format => 'fat32') }
        assert_equal ":format must be one of the follwing: all, vinyl, seveninch, digital, poster, shirt, cd", ex.message
      end

      should 'have no errors on response' do
        response = Request.get(:artist => "townes van zandt")
        assert_equal [], response.errors
      end

    end

  end
end