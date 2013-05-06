module InsoundApi
  class ObjectBase

    def initialize(node)
      @node = node
    end

    def url
      @url ||= parse_str('url')
    end

    def title
      @title ||= parse_str('title')
    end

    private

    def parse_str(selector)
      Results.parse_str(selector, @node)
    end

    def parse_int(selector)
      Results.parse_int(selector, @node)
    end

  end
end
