class IndexController < ApplicationController
  api :GET, "/", "Message for application working"
  def index
    render json: { message: "Welcome to AG back-end" }
  end
end
