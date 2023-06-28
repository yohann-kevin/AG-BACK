class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show update destroy]
  skip_before_action :authorized, only: %i[index show create update destroy]

  # GET /articles
  def index
    # Retrieve all article IDs
    articles_id = Article.order(created_at: :desc).select(:id).all
    @articles = []
    articles_id.each do |id|
      # Find all article data for each ID
      @articles << find_all_article_data(id[:id])
    end

    render json: @articles
  end

  # GET /articles/1
  def show
    # Find article data along with associated pictures
    render json: find_article_data_with_pictures(@article.id)
  end

  # POST /articles
  def create
    request_data = JSON.parse(request.body.read)
    article_data = request_data["article"]
    @article = Article.new(article_data)

    if @article.save
      # Upload and register the main picture
      main_picture_data = request_data["main_picture"][0]
      main_picture_cloudinary_data = CloudinaryService.new.upload_article_image(main_picture_data)
      register_main_picture(main_picture_cloudinary_data[:image_path], @article.id,
                            main_picture_cloudinary_data[:cloudinary_id])

      # Upload and register all article pictures
      register_article_picture(request_data["all_pictures"], @article.id)
      render json: find_all_article_data(@article.id)
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/1
  def update
    if @article.update(article_params)
      # Update the main picture if provided
      update_main_picture(params[:main_picture][0]) if params[:main_picture].present?

      # Update the article pictures if provided
      update_article_pictures(params[:all_pictures]) if params[:all_pictures].present?

      render json: find_article_data_with_pictures(@article.id)
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
    params.require(:article).permit(:title, :description, :event_at,
                                    article_pictures_attributes: %i[id picture_path main_picture _destroy])
  end

  def register_main_picture(picture_path, article_id, cloudinary_id)
    # Register the main picture for the article
    ArticlePicture.register_picture(picture_path, article_id, true, cloudinary_id)
  end

  def register_article_picture(images_data, article_id)
    images_data.each do |image|
      # Upload and register each article picture
      picture_data = CloudinaryService.new.upload_article_image(image)
      ArticlePicture.register_picture(picture_data[:image_path], article_id, false, picture_data[:cloudinary_id])
    end
  end

  def find_article_data_with_pictures(id)
    # Find article data along with associated pictures
    article = Article.find(id)
    article_data = article.attributes
    article_data[:article_pictures] = article.article_pictures.select(:id, :picture_path, :main_picture)
    article_data
  end

  # Find all article data by ID
  def find_all_article_data(id)
    {
      article: Article.find(id),
      article_pictures: ArticlePicture.select(:id, :picture_path, :main_picture).where(article_id: id)
    }
  end

  # Update the main picture of the article
  def update_main_picture(main_picture_data)
    main_picture_cloudinary_data = CloudinaryService.new.upload_article_image(main_picture_data)
    @article.article_pictures.where(main_picture: true).update(main_picture: false)
    @article.article_pictures.create(picture_path: main_picture_cloudinary_data[:image_path], main_picture: true,
                                     cloudinary_id: main_picture_cloudinary_data[:cloudinary_id])
  end

  # Update the article pictures
  def update_article_pictures(all_pictures_data)
    @article.article_pictures.destroy_all
    all_pictures_data.each do |image_data|
      picture_data = CloudinaryService.new.upload_article_image(image_data)
      @article.article_pictures.create(picture_path: picture_data[:image_path], main_picture: false,
                                       cloudinary_id: picture_data[:cloudinary_id])
    end
  end
end
