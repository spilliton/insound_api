module InsoundApi
  class Results

    attr_reader :search_url, :total_results
    attr_reader :products, :products_total
    attr_reader :artists, :artists_total

    # takes a nokogiri document
    def initialize(doc)
      @search_url = Results.parse_str('search_url', doc)
      @products = Results.parse_objects('product_matches product', Product, doc)
      @products_total = Results.parse_int('total_product_results', doc)
      @artists = Results.parse_objects('artist_matches artist', Artist, doc)
      @artists_total = Results.parse_int('total_artist_results', doc)
      @total_results = Results.parse_int('total_results', doc)
    end


    def self.parse_objects(selector, klass, doc)
      nodes = doc.css(selector)
      nodes.map{|n| klass.new(n) }
    end


    def self.parse_int(selector, doc)
      nodes = doc.css(selector)
      if nodes.any?
        nodes.first.inner_text.strip.to_i
      else
        0
      end
    end


    def self.parse_str(selector, doc)
      nodes = doc.css(selector)
      if nodes.any?
        nodes.first.inner_text.strip
      end
    end

  end
end