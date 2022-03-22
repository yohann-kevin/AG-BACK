class MannequinController < ApplicationController
  skip_before_action :authorized, only: %i[home_model_data all_model_data add_model_data]

  def home_model_data
    model_data = Model.select(:id, :firstname)
    res = []
    model_data.each do |model|
      res << {
        model: model,
        model_info: ModelInfo.select(:id, :description).find_by(model_uuid: model.id),
        model_picture: ModelPicture.select(:id, :picture_path).find_by(model_uuid: model.id, main_picture: true)
      }
    end

    render json: res
  end

  def all_model_data
    res = find_all_model_data(params[:id])
    render json: res
  end

  def add_model_data
    request_data = JSON.parse(request.body.read)
    model_id = SecureRandom.uuid
    model = Model.register_model(request_data["model"], model_id)
    model_info = ModelInfo.register_model_info(request_data["model_info"], model_id)
    model_network = ModelNetwork.register_model_network(request_data["model_network"], model_id)
    # TODO: manage model image

    if model && model_info && model_network
      render json: find_all_model_data(model_id), status: :created
    else
      render json: @model_network.errors, status: :unprocessable_entity
    end
  end

  private

  # TODO: replace ActiveRecord method on model
  def find_all_model_data(id)
    {
      model: Model.find(id),
      model_infos: ModelInfo.select(:id, :size, :weight, :chest, :waist, :hips, :shoe_size, :color, :hair_color, :eyes,
                                    :astrological, :description).find_by(model_uuid: id),
      model_networks: ModelNetwork.select(:id, :instagram, :facebook, :snapchat, :tiktok,
                                          :twitter).find_by(model_uuid: id),
      model_pictures: ModelPicture.select(:id, :picture_path, :main_picture).where(model_uuid: id)
    }
  end

  def model_params
    params.permit(:id)
  end
end
