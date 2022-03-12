class ApplicationController < ActionController::API
  around_action :manage_error
  before_action :authorized

  def auth_header
    request.headers["Authorization"]
  end

  def decoded_token
    return unless auth_header

    token = auth_header.split(" ")[1]
    begin
      JWT.decode(token, nil, false)
    rescue JWT::DecodeError
      nil
    end
  end

  def logged_in_admin
    return unless decoded_token

    admin_id = decoded_token[0]["admin_id"]
    @admin = Administrator.find_by(id: admin_id)
  end

  def logged_in?
    !!logged_in_admin
  end

  def authorized
    render json: { message: "Please log in" }, status: :unauthorized if ENV["RAILS_ENV"] != "test" && !logged_in?
  end

  protected

  def manage_error
    yield
  rescue StandardError => e
    raise e
  end
end
