class ArticlePicture < ApplicationRecord
  def self.register_picture(picture_path, article_id, is_main_picture, cloudinary_id)
    ArticlePicture.create({ picture_path: picture_path, article_id: article_id, main_picture: is_main_picture,
                            cloudinary_id: cloudinary_id })
  end

  def self.change_main_picture(picture, article_id)
    last_main_picture = ArticlePicture.find_by(article_id: article_id, main_picture: true)
    last_main_picture.main_picture = false
    last_main_picture.save
    picture.main_picture = true
    picture.save
  end
  # Defines a belongs_to association with the Article model
  belongs_to :article
end
