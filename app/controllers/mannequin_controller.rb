class MannequinController < ApplicationController
  skip_before_action :authorized, only: %i[all_model_data]

  def all_model_data
    res = {
      model: Model.find(model_params[:id]),
      model_picture: ModelPicture.find_by(model_uuid: model_params[:id])
    }
    render json: res
  end

  private

  def model_params
    params.permit(:id)
  end
end
