class BookSearchController < ApplicationController
  before_action :check_params do
    check_params(params)
  end

  def index  
    result = BookSearchFacade.find_weather_and_books(params[:location], params[:quantity])

    render json: BookSearchSerializer.weather_and_books(result[:weather], result[:books])
  end

  private

  def check_params(params)
    if params[:quantity] <= 0
      render json: { error: 'quantity must be greater than 0' }

    elsif !params[:quantity].is_a? Integer
      render json: { error: 'quantity must be a whole number' }
    end
  end
end
