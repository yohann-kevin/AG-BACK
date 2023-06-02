class Article < ApplicationRecord
  def self.register_article(article_data, article_id)
    article = Article.new(article_data)
    article.id = article_id
    article.save ? true : false
  end

  def self.update_article_data(data_info, article_id)
    article = Article.find(article_id)
    article.update(data_info) ? true : false
  end

  # Defines a one-to-many association with the ArticlePicture model
  # Specifies dependent: :destroy, meaning associated article pictures will be destroyed when an article is destroyed
  has_many :article_pictures, dependent: :destroy
end
