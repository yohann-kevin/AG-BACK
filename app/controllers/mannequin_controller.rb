class MannequinController < ApplicationController
  skip_before_action :authorized, only: %i[all_model_data]

  def all_model_data
    res = {
      model: Model.find(model_params[:id]),
      model_infos: ModelInfo.select(:id, :size, :weight, :chest, :waist, :hips, :shoe_size, :color, :hair_color,
                                    :astrological, :description).find_by(model_uuid: model_params[:id]),
      model_networks: ModelNetwork.select(:id, :instagram, :facebook, :snapchat, :tiktok,
                                          :twitter).find_by(model_uuid: model_params[:id]),
      model_pictures: ModelPicture.select(:id, :picture_path, :main_picture).where(model_uuid: model_params[:id])
    }
    render json: res
  end

  private

  def model_params
    params.permit(:id)
  end
end
