class CloudinaryService
  def initialize
    Cloudinary.config_from_url ENV["CLOUDINARY_URL"]
  end

  def upload_model_image(image_data)
    res = Cloudinary::Uploader.upload(image_data)
    { image_path: res["secure_url"], cloudinary_id: res["public_id"] }
  end

  def destroy_model_image(public_id)
    Cloudinary::Uploader.destroy(public_id)
  end
end
