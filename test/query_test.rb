$:.unshift '.';require File.dirname(__FILE__) + '/helper'

module InsoundApi
  class QueryTest < Test::Unit::TestCase

    context 'with credentials' do
      setup do
        setup_credentials
      end

      context 'search by artist returning no results' do
        setup do
          mock(:no_results_found, "?artist=xxcxccxcx")
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
          mock(:jimmy_eat_world_vinyl, "?artist=Jimmy%20Eat%20World&format=vinyl")
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

      context 'search with bumped maxresults' do
        setup do
          mock(:maxresults, "?artist=arcade&maxresults=100")
          @results = Query.search(:artist => 'arcade', :maxresults => 100)
        end

        should 'return multiple artists and products' do
          assert_equal 30, @results.products.length
          assert_equal 7, @results.artists.length

          assert_equal 30, @results.products_total
          assert_equal 7, @results.artists_total
          assert_equal 37, @results.total_results
          assert_nil @results.search_url

          product = @results.products.first
          assert product.url
          assert_equal 'Arcade Fire', product.artist_name
          assert_equal 'Funeral', product.title
          assert_equal 'CD', product.format
          assert_equal 'INS23877', product.id

          artist = @results.artists.first
          assert artist.url
          assert_equal 'Arcade Fire', artist.name
          assert_equal 29908, artist.id
        end
      end


      context 'search using title' do
        setup do
          mock(:zen_arcade, "?artist=husker&title=zen%20arcade")
          @results = Query.search(:artist => 'husker', :title => 'zen arcade')
        end

        should 'return multiple artists and products' do
          assert_equal 2, @results.products.length
          assert_equal 1, @results.artists.length

          assert_equal 2, @results.products_total
          assert_equal 1, @results.artists_total
          assert_equal 3, @results.total_results
          assert_nil @results.search_url

          product = @results.products.first
          assert product.url
          assert_equal 'Husker Du', product.artist_name
          assert_equal 'Zen Arcade', product.title
          assert_equal 'Vinyl LP', product.format
          assert_equal 'INS13241', product.id

          artist = @results.artists.first
          assert artist.url
          assert_equal 'Husker Du', artist.name
          assert_equal 21544, artist.id
        end
      end

    end



  end
end