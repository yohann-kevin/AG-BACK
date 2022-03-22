require "cloudinary"
require "json"

class UploadImageController < ApplicationController
  def upload_image(image_data)
    Cloudinary.config_from_url ENV["CLOUDINARY_URL"]

    begin
      res = Cloudinary::Uploader.upload(image_data)
      render json: res
    rescue StandardError => e
      Rails.logger.debug e
      render json: { error: e }
    end
  end
end
