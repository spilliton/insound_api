module InsoundApi
  class Product

    attr_reader :url, :id, :title
    attr_reader :artist_name, :format


    def initialize(node)
      @url = Results.parse_str('url', node)
      @id = Results.parse_str('product_id', node)
      @title = Results.parse_str('title', node)
      @artist_name = Results.parse_str('artist_name', node)
      @format = Results.parse_str('format', node)
    end

  end
end