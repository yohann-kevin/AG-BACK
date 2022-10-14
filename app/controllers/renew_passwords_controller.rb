class RenewPasswordsController < ApplicationController
  before_action :set_renew_password, only: %i[show update destroy]
  before_action :set_renew_password_secure_id, only: [:check_secure_id, :renew_password]
  skip_before_action :authorized, only: %i[index create show update destroy check_secure_id renew_password]

  # GET /renew_passwords
  def index
    @renew_passwords = RenewPassword.all

    render json: @renew_passwords
  end

  # GET /renew_passwords/1
  def show
    render json: @renew_password
  end

  # POST /renew_passwords
  def create
    agent_data = JSON.parse(request.body.read)
    @agent = Agent.find_by(email: agent_data["agent_email"])

    if @agent
      agent_data["agent_id"] = @agent.id
      agent_data["secure_id"] = SecureRandom.uuid
      @renew_password = RenewPassword.new(agent_data)

      if @renew_password.save
        PasswordMailer.with(renew_password: @renew_password).new_password_mailer.deliver_later
        render json: { message: "mail sending" }
      end
    else
      render json: { message: "Please log in" }, status: :unauthorized
    end
  end

  def check_secure_id
    render json: @renew_password
  end

  def renew_password
    new_password = JSON.parse(request.body.read)["password"]
    agent_id = @renew_password[:agent_id]
    @agent = Agent.find(agent_id)
    @agent.password = BCrypt::Password.create(new_password)
    @renew_password.active = false
    if @agent.save && @renew_password.save
      render json: @agent
    else
      render json: @renew_password.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /renew_passwords/1
  def update
    if @renew_password.update(renew_password_params)
      render json: @renew_password
    else
      render json: @renew_password.errors, status: :unprocessable_entity
    end
  end

  # DELETE /renew_passwords/1
  def destroy
    @renew_password.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_renew_password
    @renew_password = RenewPassword.find(params[:id])
  end

  def set_renew_password_secure_id
    @renew_password = RenewPassword.find_by(secure_id: params[:secure_id])
  end

  # Only allow a list of trusted parameters through.
  def renew_password_params
    params.require(:renew_password).permit(:agent_id, :secure_id, :agent_email, :active)
  end
end
