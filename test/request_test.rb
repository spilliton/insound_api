$:.unshift '.';require File.dirname(__FILE__) + '/helper'

module InsoundApi
  class RequestTest < Test::Unit::TestCase

    context 'with credentials' do
      setup do
        setup_credentials
      end

      should 'raise if errors in response' do
        if !mocking?
          setup_test_credentials
        end

        mock(:bad_credentials, "?artist=townes%20van%20zandt&id=42&password=yyyyyy")
        ex = assert_raise(RequestException) { Request.get(:artist => "townes van zandt") }
        assert ex.message =~ /Invalid account information/i
      end

      should 'correctly build_url' do
        if mocking?
          request = Request.new(:artist => "townes van zandt")
          assert_equal 'https://www.insound.com/ws/affiliate/?id=42&password=fart&artist=townes%20van%20zandt', request.build_url
        end
      end

      should 'raise RequestException if artist not provided' do
        ex = assert_raise(RequestException) { Request.get }
        assert_equal ":artist is a required param for any request", ex.message
      end

      should 'raise RequestException if invalid format provided' do
        ex = assert_raise(RequestException) { Request.get(:artist => 'blah', :format => 'fat32') }
        assert_equal ":format must be one of the follwing: all, vinyl, seveninch, digital, poster, shirt, cd", ex.message
      end

    end

  end
end