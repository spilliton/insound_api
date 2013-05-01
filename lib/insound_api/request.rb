require 'rest_client'

module InsoundApi

  class Request

    attr_reader :method, :path, :params, :param_name

    def initialize(opts={})
      @method = opts[:method]
      @path = opts[:path]
      @params = opts[:params] || {}
      @param_name = opts[:param_name]
    end

    def self.get(path, opts={})
      request = Request.new(opts.merge(:path => path))
      request.get_response
    end

    def get_response
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
      Response.new(:raw_xml => data.to_str, :request => self, :status => data.code)  
    end

    def build_params
      {param_name => params}
    end

    def build_url
      url = "#{mothership_url}#{path}" 
      if params.any? && method == :get
        parts = []
        params.each_pair do |name, value|
          parts << "#{URI.escape(name.to_s)}=#{URI.escape(value.to_s)}"
        end
        url = "#{url}?#{parts.join('&')}"
      end
      url
    end

  end
end