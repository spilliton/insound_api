require 'helper'

module InsoundApi
  class RequestTest < Test::Unit::TestCase

    context 'with invalid credentials' do
      setup do
        setup_bad_credentials
      end

      should 'correctly build_url' do
        request = Request.new(:artist => "townes van zandt")
        assert_equal 'https://www.insound.com/ws/affiliate/?id=2342423&password=yyyyyy&artist=townes%20van%20zandt', request.build_url
      end

      should 'have errors on response' do
        response = Request.get(:artist => "townes van zandt")
        assert response.errors?
        assert_equal([{:code=>"102", :text=>"Invalid account information."}], response.errors)
      end
    end


    context 'with valid credentials' do
      setup do
        setup_credentials_from_config
      end

      should 'have no errors on response' do
        response = Request.get(:artist => "townes van zandt")

        puts "response.request.build_url: #{response.request.build_url.inspect}"


        assert_equal [], response.errors
      end

    end

  end
end