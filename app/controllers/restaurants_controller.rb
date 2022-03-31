class RestaurantsController < ApplicationController
  before_action :authenticate_user!

  def search
    large_areas_uri = URI.parse("https://webservice.recruit.co.jp/hotpepper/large_area/v1/?key=#{ENV['HPG_KEY']}&format=json")
    large_areas_response = Net::HTTP.get_response(large_areas_uri)
    large_areas = JSON.parse(large_areas_response.body)
    @large_area_list = large_areas["results"]["large_area"]

    genre_uri = URI.parse("https://webservice.recruit.co.jp/hotpepper/genre/v1/?key=#{ENV['HPG_KEY']}&format=json")
    genre_response = Net::HTTP.get_response(genre_uri)
    genres = JSON.parse(genre_response.body)
    @genre_list = genres["results"]["genre"]
  end

  def index
    @restaurant = Restaurant.new
    uri = "http://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=#{ENV['HPG_KEY']}&count=50&format=json"
    if genre = params[:genre]
      genre = URI.encode_www_form({ genre: genre })
      uri << "&" << genre
    end
    if large_area = params[:large_area]
      large_area = URI.encode_www_form({ large_area: large_area })
      uri << "&" << large_area
    end
    if name = params[:name]
      name = URI.encode_www_form({ name: name })
      uri << "&" << name
    end
    uri = URI.parse(uri)
    response = Net::HTTP.get_response(uri)
    result = JSON.parse(response.body)
    @restaurants = result["results"]["shop"]

    respond_to do |format|
      format.html { redirect_to search_path }
      format.js
    end
  end

  def new
    @restaurant = Restaurant.new
    @restaurant.name = params[:name]
    @restaurant.url = params[:url]
    @restaurant.image_url = params[:restaurant_image]
    @restaurant.address = params[:address]
    @restaurant.catch = params[:catch]
    session[:restaurant] = @restaurant
    redirect_to confirm_events_path
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :url, :restaurant_image, :catch, :address)
  end
end
