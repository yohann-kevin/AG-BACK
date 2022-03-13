class ModelsController < ApplicationController
  before_action :set_model, only: %i[show update destroy]
  skip_before_action :authorized, only: %i[index show create update destroy]

  # GET /models
  def index
    @models = Model.all

    render json: @models
  end

  # GET /models/1
  def show
    render json: @model
  end

  # POST /models
  def create
    @model = Model.new(model_params)

    if @model.save
      render json: @model, status: :created, location: @model
    else
      render json: @model.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /models/1
  def update
    if @model.update(model_params)
      render json: @model
    else
      render json: @model.errors, status: :unprocessable_entity
    end
  end

  # DELETE /models/1
  def destroy
    @model.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_model
    @model = Model.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def model_params
    # params.require(:model).permit(:firstname, :lastname, :email, :phone, :address, :birth_date)
    params.permit(:firstname, :lastname, :email, :phone, :address, :birth_date)
  end
end
