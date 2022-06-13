class Api::V1::BookSearchController < ApplicationController
  before_action { check_params(params) }

  def index  
    result = BookSearchFacade.find_weather_and_books(params[:location], params[:quantity])

    render json: Api::V1::BookSearchSerializer.weather_and_books(params[:location], result[:weather], result[:books])
  end

  private

  def check_params(params)
    if !(/\A\d+\z/).match? params[:quantity]
      render json: { error: 'quantity must be a whole number' }, status: 400
    end
  end
end
