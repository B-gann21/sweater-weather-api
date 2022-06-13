class Api::V1::ForecastController < ApplicationController
  def index
    full_forecast = ForecastFacade.full_forecast(params[:location])

    render json: Api::V1::ForecastSerializer.forecast_index(full_forecast)
  end
end
