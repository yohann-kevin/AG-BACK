require "cloudinary"

class ArticlePicturesController < ApplicationController
  before_action :set_article_picture, only: [:show, :update, :destroy]

  # GET /article_pictures
  def index
    @article_pictures = ArticlePicture.all

    render json: @article_pictures
  end

  # GET /article_pictures/1
  def show
    render json: @article_picture
  end

  # POST /article_pictures
  def create
    request_data = JSON.parse(request.body.read)
    picture_data = request_data["picture_data"]
    article_id = request_data["article_id"]
    picture_data = CloudinaryService.new.upload_article_image(picture_data)
    register_new_picture(picture_data[:image_path], article_id, picture_data[:cloudinary_id])
    all_article_pictures = ArticlePicture.where(article_id: article_id)
  
    render json: all_article_pictures, status: :created
  end
  

  # PATCH/PUT /article_pictures/1
  def update
    if @article_picture.update(article_picture_params)
      render json: @article_picture
    else
      render json: @article_picture.errors, status: :unprocessable_entity
    end
  end

  # DELETE /article_pictures/1
  def destroy
    CloudinaryService.new.destroy_article_image(@article_picture.cloudinary_id)
    @article_picture.destroy
    article_pictures = ArticlePicture.where(article_id: @article_picture.article_id)
    render json: article_pictures
  end

  def modify_main_picture
    article_id = params[:article_id]
    ArticlePicture.change_main_picture(@article_picture, article_id)
    article_pictures = ArticlePicture.where(article_id: article_id)
    render json: article_pictures
  end
  
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article_picture
      @article_picture = ArticlePicture.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_picture_params
      params.require(:article_picture).permit(:article_id, :picture_path, :main_picture)
    end
end
