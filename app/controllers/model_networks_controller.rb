class ModelNetworksController < ApplicationController
  before_action :set_model_network, only: [:show, :update, :destroy]

  # GET /model_networks
  def index
    @model_networks = ModelNetwork.all

    render json: @model_networks
  end

  # GET /model_networks/1
  def show
    render json: @model_network
  end

  # POST /model_networks
  def create
    @model_network = ModelNetwork.new(model_network_params)

    if @model_network.save
      render json: @model_network, status: :created, location: @model_network
    else
      render json: @model_network.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /model_networks/1
  def update
    if @model_network.update(model_network_params)
      render json: @model_network
    else
      render json: @model_network.errors, status: :unprocessable_entity
    end
  end

  # DELETE /model_networks/1
  def destroy
    @model_network.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_model_network
      @model_network = ModelNetwork.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def model_network_params
      params.require(:model_network).permit(:model_uuid, :instagram, :facebook, :snapchat, :tiktok, :twitter)
    end
end
