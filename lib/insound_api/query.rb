module InsoundApi
  class Query

    def self.search(params)
      response = Request.get(params)
      response.results
    end

    # not yet supported
    # def self.product_search(params={})
    #   params[:requesttype] = 'product'
    #   response = Request.get(params)
    #   response.results
    # end

  end
end