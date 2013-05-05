module InsoundApi
  class Results

    attr_reader :warnings, :doc

    # takes a nokogiri document
    def initialize(document)
      @doc = document
    end

    def search_url
      @search_url ||= parse_str('search_url')
    end

    def products
      @products ||= parse_objects('product_matches product', Product)
    end

    def products_total
      @products_total ||= parse_int('total_product_results')
    end

    def artists
      @artists ||= parse_objects('artist_matches artist', Artist)
    end

    def artists_total
      @artists_total ||= parse_int('total_artist_results')
    end

    def total_results
      @total_results ||= parse_int('total_results')
    end



    def parse_objects(selector, klass)
      nodes = doc.css(selector)
      nodes.map{|n| klass.new(n) }
    end


    def parse_int(selector)
      Results.parse_int(selector, doc)
    end

    def self.parse_int(selector, doc)
      nodes = doc.css(selector)
      if nodes.any?
        nodes.first.inner_html.to_i
      else
        0
      end
    end

    def parse_str(selector)
      Results.parse_str(selector, doc)
    end

    def self.parse_str(selector, doc)
      nodes = doc.css(selector)
      if nodes.any?
        nodes.first.inner_html
      end
    end

  end
end