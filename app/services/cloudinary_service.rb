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

  def find_picture_not_delete
    all_cloudinary_pictures = Cloudinary::Api.resources(max_results: 1000)
    all_public_id = all_cloudinary_pictures["resources"].map { |picture| picture["public_id"] }

    all_picture = ModelPicture.select(:id, :cloudinary_id).all.to_a
    all_cloudinary_id = all_picture.map(&:cloudinary_id)
    all_public_id - all_cloudinary_id
  end
end
