class RestaurantsController < ApplicationController
  def search
    large_areas_uri = URI.parse("https://webservice.recruit.co.jp/hotpepper/large_area/v1/?key=#{ENV["HPG_KEY"]}&format=json")
    large_areas_response = Net::HTTP.get_response(large_areas_uri)
    large_areas = JSON.parse(large_areas_response.body)
    @large_area_list = large_areas["results"]["large_area"]

    genre_uri = URI.parse("https://webservice.recruit.co.jp/hotpepper/genre/v1/?key=#{ENV["HPG_KEY"]}&format=json")
    genre_response = Net::HTTP.get_response(genre_uri)
    genres = JSON.parse(genre_response.body)
    @genre_list = genres["results"]["genre"]
  end

  def index
    uri = "http://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=#{ENV["HPG_KEY"]}&count=50&format=json"
    if genre = params[:genre]
      genre = URI.encode_www_form({genre: genre})
      uri << "&" << genre
    end
    if large_area = params[:large_area]
      large_area = URI.encode_www_form({large_area: large_area})
      uri << "&" << large_area
    end
    if name = params[:name]
      name = URI.encode_www_form({name: name})
      uri << "&" << name
    end
    uri = URI.parse(uri)
    response = Net::HTTP.get_response(uri)
    result = JSON.parse(response.body)
    @restaurants = result["results"]["shop"]
  end
end
