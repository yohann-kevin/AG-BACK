require "bcrypt"

class AgentsController < ApplicationController
  before_action :set_agent, only: [:show, :update, :destroy]
  skip_before_action :authorized, only: [:index, :show, :create, :login, :update, :destroy]

  # GET /agents
  def index
    @agents = Agent.all

    render json: @agents
  end

  # GET /agents/1
  def show
    render json: @agent
  end

  # POST /agents
  def create
    agent_data = JSON.parse(request.body.read)
    agent_data["id"] = SecureRandom.uuid
    agent_data["password"] = BCrypt::Password.create(agent_data["password"])
    @agent = Agent.new(agent_data)

    if @agent.save
      payload = { agent_id: @agent.id, is_agent: true }
      token = JWT.encode(payload, nil, "HS256")
      agent_data = @agent.attributes.except('password')
      render json: { token: token, agent_data: agent_data }, status: :created, location: @agent
    else
      render json: @agent.errors, status: :unprocessable_entity
    end
  end

  # POST /agent/auth
  def login
    request_data = JSON.parse(request.body.read)
    @agent = Agent.find_agent_by_email(request_data["email"])
    return undefined_user if @agent.nil?

    password = BCrypt::Password.new(@agent.password)
    if password == request_data["password"]
      payload = { agent_id: @agent.id, is_agent: true }
      token = JWT.encode(payload, nil, "HS256")
      agent_data = @agent.attributes.except('password')
      render json: { token: token, agent_data: agent_data }
    else
      undefined_user
    end
  end

  # PATCH/PUT /agents/1
  def update
    if @agent.update(agent_params)
      render json: @agent
    else
      render json: @agent.errors, status: :unprocessable_entity
    end
  end

  # DELETE /agents/1
  def destroy
    @agent.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_agent
      @agent = Agent.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def agent_params
      params.require(:agent).permit(:firstname, :lastname, :email, :password, :cgu)
    end

    def undefined_user
      render status: :unauthorized
    end
end
