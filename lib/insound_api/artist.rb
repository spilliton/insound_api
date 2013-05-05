module InsoundApi
  class Artist < ObjectBase

    def name
      @name ||= parse_str('artist_name')
    end

    def format
      @format ||= parse_str('format')
    end

    def id
      @id ||= parse_int('artist_id')
    end


  end
end