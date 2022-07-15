class ModelPicturesController < ApplicationController
  before_action :set_model_picture, only: %i[show update destroy modify_main_picture]
  skip_before_action :authorized, only: %i[destroy modify_main_picture]

  # GET /model_pictures
  def index
    @model_pictures = ModelPicture.all

    render json: @model_pictures
  end

  # GET /model_pictures/1
  def show
    render json: @model_picture
  end

  # POST /model_pictures
  def create
    @model_picture = ModelPicture.new(model_picture_params)

    if @model_picture.save
      render json: @model_picture, status: :created, location: @model_picture
    else
      render json: @model_picture.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /model_pictures/1
  def update
    if @model_picture.update(model_picture_params)
      render json: @model_picture
    else
      render json: @model_picture.errors, status: :unprocessable_entity
    end
  end

  # DELETE /model_pictures/1
  def destroy
    @model_picture.destroy
    model_pictures = ModelPicture.where(model_uuid: @model_picture.model_uuid)
    render json: model_pictures
  end

  def modify_main_picture
    model_id = params[:model_uuid]
    ModelPicture.change_main_picture(@model_picture, model_id)
    model_pictures = ModelPicture.where(model_uuid: model_id)
    render json: model_pictures
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_model_picture
    @model_picture = ModelPicture.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def model_picture_params
    params.require(:model_picture).permit(:model_uuid, :picture_path, :main_picture)
  end
end
