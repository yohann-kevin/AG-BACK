require "bcrypt"

class AdministratorsController < ApplicationController
  before_action :set_administrator, only: [:show, :update, :destroy]
  skip_before_action :authorized, only: [:create, :login]

  # GET /administrators
  def index
    @administrators = Administrator.all

    render json: @administrators
  end

  # GET /administrators/1
  def show
    render json: @administrator
  end

  def create
    admin = {
      email: administrator_params["email"],
      name: administrator_params["name"],
      password: BCrypt::Password.create(administrator_params["password"])
    }
    @administrator = Administrator.new(admin)

    if @administrator.save
      render json: @administrator, status: :created, location: @administrator
    else
      render json: @administrator.errors, status: :unprocessable_entity
    end
  end

  def login
    user_info = JSON.parse(request.body.read)
    administrator = Administrator.find_admin_by_login(user_info["login"])
    return undefined_user if administrator.nil?
    password = BCrypt::Password.new(administrator.password)
    if password == user_info["password"]
      payload = { admin_id: administrator.id, is_admin: true }
      token = JWT.encode(payload, nil, "HS256")
      render json: { token: token, admin_data: administrator }
    else
      return undefined_user
    end
  end

  # PATCH/PUT /administrators/1
  def update
    if @administrator.update(administrator_params)
      render json: @administrator
    else
      render json: @administrator.errors, status: :unprocessable_entity
    end
  end

  # DELETE /administrators/1
  def destroy
    @administrator.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_administrator
      @administrator = Administrator.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def administrator_params
      # params.require(:administrator).permit(:email, :name, :password)
      params.permit(:email, :name, :password)
    end

    # TODO: manage response if user nis undefined
    def undefined_user
      render json: { message: "undefined users !" }
    end
end
