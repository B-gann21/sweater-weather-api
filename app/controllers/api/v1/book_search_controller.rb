class Api::V1::BookSearchController < ApplicationController
  before_action :check_params 

  def index  
    result = BookSearchFacade.find_weather_and_books(params[:location], params[:quantity])

    render json: Api::V1::BookSearchSerializer.weather_and_books(
                                                                  params[:location],
                                                                  result[:weather],
                                                                  result[:books],
                                                                  result[:total_books]
                                                                )
  end
end
