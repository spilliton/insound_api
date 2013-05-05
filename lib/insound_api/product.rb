module InsoundApi
  class Product < ObjectBase

    def artist_name
      @artist_name ||= parse_str('artist_name')
    end

    def format
      @format ||= parse_str('format')
    end

    def id
      @id ||= parse_str('product_id')
    end

  end
end