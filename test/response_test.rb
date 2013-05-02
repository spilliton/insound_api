require 'helper'

module InsoundApi
  class ResponseTest < Test::Unit::TestCase

    should 'parse xml into a nokogiri document' do
      response = Response.new(:raw_xml => '<blah>1</blah>')
      doc = response.doc

      assert_equal Nokogiri::XML::Document, doc.class
      assert_equal '1', doc.css('blah').first.inner_html
    end

    should 'report errors if any' do
      xml = <<THEXML
<insound_query_response>
<errors>
<request_error>
<error_code>102</error_code>
<error_text>Invalid account information.</error_text>
</request_error>
<request_error>
<error_code>101</error_code>
<error_text>Missing required parameters</error_text>
</request_error>
</errors>
</insound_query_response>
THEXML

      response = Response.new(:raw_xml => xml)

      assert response.errors?

      errors = [{:code=>"102", :text=>"Invalid account information."},
                {:code=>"101", :text=>"Missing required parameters"}]
      assert_equal errors, response.errors
    end

  end
end