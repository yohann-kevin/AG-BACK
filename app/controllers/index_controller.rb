class IndexController < ApplicationController
  def index
    render json: { message: "Welcome to AG back-end" }
  end
end
