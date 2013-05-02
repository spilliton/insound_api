require 'rest_client'

module InsoundApi

  class Request

    BASE_URL = "https://www.insound.com/ws/affiliate/"

    attr_reader :params

    def initialize(opts)
      @params = opts
    end

    def self.get(opts={})
      request = Request.new(opts)
      request.get_response
    end

    def get_response
      InsoundApi.config.affiliate_id

      response = nil
      url = build_url
      headers = {  }

      begin

        data = RestClient.get(url, headers)

      rescue RestClient::Unauthorized
        raise "Request rejected.  Please ensure your credentials are correct."
      end


      if data
        response = build_response(data)
      end

      response
    end

    def build_response(data)
      Response.new(:raw_xml => data.to_str, :request => self)
    end

    def build_params
      {param_name => params}
    end

    def build_url
      url = base_url_with_creds
      if params.any?
        parts = []
        params.each_pair do |name, value|
          parts << "#{URI.escape(name.to_s)}=#{URI.escape(value.to_s)}"
        end
        url = "#{url}&#{parts.join('&')}"
      end
      url
    end


    def affiliate_id
      InsoundApi.config.affiliate_id
    end

    def api_password
      InsoundApi.config.api_password
    end

    def base_url_with_creds
      "#{BASE_URL}?id=#{affiliate_id}&password=#{api_password}"
    end



  end
end