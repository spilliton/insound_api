module InsoundApi
  class Product < ApiBase

    def self.search(params={})
      params[:requesttype] = 'product'
      response = Request.get(params)
    end




  end
end