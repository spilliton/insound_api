$:.unshift '.';require File.dirname(__FILE__) + '/helper'

module InsoundApi
  class QueryTest < Test::Unit::TestCase

    context 'search by artist returning no results' do
      setup do
        setup_credentials_from_config
        @results = Query.search(:artist => 'xxcxccxcx')
      end


      should 'return empty stuff' do
        assert_equal [], @results.products
        assert_equal [], @results.artists

        assert_equal 0, @results.products_total
        assert_equal 0, @results.artists_total
        assert_equal 0, @results.total_results
        assert @results.search_url
      end
    end

    context 'search artist vinyl format' do
      setup do
        setup_credentials_from_config
        @results = Query.search(:artist => 'Jimmy Eat World', :format => 'vinyl')
      end

      should 'return actual stuff' do
        assert_equal 3, @results.products.length
        assert_equal 1, @results.artists.length

        assert_equal 3, @results.products_total
        assert_equal 1, @results.artists_total
        assert_equal 4, @results.total_results
        assert_nil @results.search_url

        product = @results.products.first
        assert product.url
        assert_equal 'Jimmy Eat World', product.artist_name
        assert_equal 'Invented', product.title
        assert_equal 'Vinyl LP', product.format
        assert_equal 'INS79668', product.id

        artist = @results.artists.first
        assert artist.url
        assert_equal 'Jimmy Eat World', artist.name
        assert_equal 19191, artist.id
      end
    end

  end
end