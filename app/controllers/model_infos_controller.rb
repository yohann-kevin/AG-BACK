class ModelInfosController < ApplicationController
  before_action :set_model_info, only: [:show, :update, :destroy]

  # GET /model_infos
  def index
    @model_infos = ModelInfo.all

    render json: @model_infos
  end

  # GET /model_infos/1
  def show
    render json: @model_info
  end

  # POST /model_infos
  def create
    @model_info = ModelInfo.new(model_info_params)

    if @model_info.save
      render json: @model_info, status: :created, location: @model_info
    else
      render json: @model_info.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /model_infos/1
  def update
    if @model_info.update(model_info_params)
      render json: @model_info
    else
      render json: @model_info.errors, status: :unprocessable_entity
    end
  end

  # DELETE /model_infos/1
  def destroy
    @model_info.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_model_info
      @model_info = ModelInfo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def model_info_params
      params.require(:model_info).permit(:model_uuid, :size, :weight, :chest, :waist, :hips, :shoe_size, :color, :hair_color, :astrological, :description)
    end
end
