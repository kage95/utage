class RestaurantsController < ApplicationController
  def search
    large_areas_uri = URI.parse("https://webservice.recruit.co.jp/hotpepper/large_area/v1/?key=#{ENV["HPG_KEY"]}&format=json")
    large_areas_response = Net::HTTP.get_response(large_areas_uri)
    large_areas = JSON.parse(large_areas_response.body)
    @large_area_list = large_areas["results"]["large_area"]
  end

  def index
    large_area = params[:large_area]
    params = URI.encode_www_form({large_area: large_area})
    uri = URI.parse("http://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=#{ENV["HPG_KEY"]}&#{params}&count=50&format=json")
    response = Net::HTTP.get_response(uri)
    result = JSON.parse(response.body)
    @restaurants = result["results"]["shop"]
  end
end
