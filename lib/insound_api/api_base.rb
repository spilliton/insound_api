module InsoundApi
  module ApiBase

    def base_path(val)
      @base_path = val
    end

    def param_name(val)
      @param_name = val
    end

    def all(params={})
      response = Request.get(@base_path, :params => params)
      response.to_a
    end

    def find(id)
      response = Request.get("#{@base_path}/#{id}")
      response.to_struct
    end

    def create(params)
      response = Request.post(@base_path, :params => params, :param_name => @param_name)
      response.to_struct
    end

  end
end