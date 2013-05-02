require 'helper'

class ConfigTest < Test::Unit::TestCase

  should 'raise exception if not configured' do
    assert_raise InsoundApi::ConfigException do
      InsoundApi::Request.get
    end
  end

end
