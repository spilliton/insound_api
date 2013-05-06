require 'rest_client'

module InsoundApi

  class RequestException < Exception; end

  class Request

    BASE_URL = "https://www.insound.com/ws/affiliate/"
    VALID_FORMATS = %w{all vinyl seveninch digital poster shirt cd}

    attr_reader :params

    def initialize(opts={})
      unless opts[:artist]
        raise RequestException, ":artist is a required param for any request"
      end

      if opts[:format] && !VALID_FORMATS.include?(opts[:format].downcase)
        raise RequestException, ":format must be one of the follwing: #{VALID_FORMATS.join(', ')}"
      end

      @params = opts
    end

    def self.get(opts={})
      request = Request.new(opts)
      request.get_response
    end

    def get_response
      data = RestClient.get(build_url)
      response = data ? build_response(data) : nil

      if response.errors?
        raise RequestException, "The following errors were returned: #{response.errors.inspect}"
      else
        response
      end
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