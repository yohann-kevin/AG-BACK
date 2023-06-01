require "test_helper"

class ArticlePicturesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article_picture = article_pictures(:one)
  end

  test "should get index" do
    get article_pictures_url, as: :json
    assert_response :success
  end

  # test "should create article_picture" do
  #   assert_difference('ArticlePicture.count') do
  #     post article_pictures_url, params: { article_picture: { article_id: @article_picture.article_id, cloudinary_id: @article_picture.cloudinary_id, main_picture: @article_picture.main_picture, picture_path: @article_picture.picture_path } }, as: :json
  #   end

  #   assert_response 201
  # end

  test "should show article_picture" do
    get article_picture_url(@article_picture), as: :json
    assert_response :success
  end

  # test "should update article_picture" do
  #   patch article_picture_url(@article_picture), params: { article_picture: { article_id: @article_picture.article_id, cloudinary_id: @article_picture.cloudinary_id, main_picture: @article_picture.main_picture, picture_path: @article_picture.picture_path } }, as: :json
  #   assert_response 200
  # end

  # test "should destroy article_picture" do
  #   assert_difference('ArticlePicture.count', -1) do
  #     delete article_picture_url(@article_picture), as: :json
  #   end

  #   assert_response 204
  # end
end
