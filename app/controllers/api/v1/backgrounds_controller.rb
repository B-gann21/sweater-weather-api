class Api::V1::BackgroundsController < ApplicationController
  def index
    background = BackgroundFacade.find_background_image(params[:location])

    render json: Api::V1::BackgroundSerializer.image_info(background)
  end
end
