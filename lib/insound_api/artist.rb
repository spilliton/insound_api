module InsoundApi
  class Artist

    attr_reader :url, :id, :name

    def initialize(node)
      @url = Results.parse_str('url', node)
      @name = Results.parse_str('artist_name', node)
      @id = Results.parse_int('artist_id', node)
    end

  end
end