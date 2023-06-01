class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show update destroy]
  skip_before_action :authorized, only: %i[index show create update destroy]

  # GET /articles
  def index
    articles_id = Article.select(:id).all
    @articles = []
    articles_id.each do |id|
      @articles << find_all_article_data(id[:id])
    end

    render json: @articles
  end

  # GET /articles/1
  def show
    render json: @article
  end

  # POST /articles
  def create
    request_data = JSON.parse(request.body.read)
    article_data = request_data["article"]
    @article = Article.new(article_data)

    if @article.save
      main_picture_data = request_data["main_picture"][0]
      main_picture_cloudinary_data = CloudinaryService.new.upload_article_image(main_picture_data)
      register_main_picture(main_picture_cloudinary_data[:image_path], @article.id,
                            main_picture_cloudinary_data[:cloudinary_id])
      register_article_picture(request_data["all_pictures"], @article.id)
      render json: find_all_article_data(@article.id)
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/1
  def update
    if @article.update(article_params)
      render json: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # DELETE /articles/1
  def destroy
    @article.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def article_params
    params.require(:article).permit(:title, :description, :event_at)
  end

  def register_main_picture(picture_path, article_id, cloudinary_id)
    ArticlePicture.register_picture(picture_path, article_id, true, cloudinary_id)
  end

  def register_article_picture(images_data, article_id)
    images_data.each do |image|
      picture_data = CloudinaryService.new.upload_article_image(image)
      ArticlePicture.register_picture(picture_data[:image_path], article_id, false, picture_data[:cloudinary_id])
    end
  end

  # find all article data by id
  def find_all_article_data(id)
    {
      article: Article.find(id),
      article_pictures: ArticlePicture.select(:id, :picture_path, :main_picture).where(article_id: id)
    }
  end
end
