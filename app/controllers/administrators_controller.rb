require "bcrypt"

class AdministratorsController < ApplicationController
  before_action :set_administrator, only: %i[update destroy]
  skip_before_action :authorized, only: %i[create login]

  # GET /administrators/1
  api :GET, "administrators", "Find administrator by token"
  def index
    render json: @admin
  end

  # POST /administrators
  api :POST, "administrators", "Create new administrator"
  def create
    admin = {
      email: administrator_params["email"],
      name: administrator_params["name"],
      password: BCrypt::Password.create(administrator_params["password"])
    }
    @administrator = Administrator.new(admin)

    if @administrator.save
      render json: @administrator, status: :created,
             location: @administrator
    else
      render json: @administrator.errors, status: :unprocessable_entity
    end
  end

  # POST /admin/auth
  api :POST, "admin/auth", "Login administrator"
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
      undefined_user
    end
  end

  # PATCH/PUT /administrators/1
  api :PUT, "administrators/:id", "Update administrator information"
  param :id, :number, desc: "Id for find administrator"
  def update
    if @administrator.update(administrator_params)
      render json: @administrator
    else
      render json: @administrator.errors, status: :unprocessable_entity
    end
  end

  # DELETE /administrators/1
  api :DELETE, "administrators/:id", "Delete administrator"
  param :id, :number, desc: "Id for find administrator"
  def destroy
    @administrator.destroy
  end

  def backup
    all_data = {
      administrators: Administrator.all,
      agents: Agent.all,
      contacts: Contact.all,
      model_data: {
        models: Model.all,
        model_infos: ModelInfo.all,
        model_networks: ModelNetwork.all,
        model_pictures: ModelPicture.all
      },
      renew_password: RenewPassword.all
    }
    render json: all_data
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

  def undefined_user
    render status: :unauthorized
  end
end
