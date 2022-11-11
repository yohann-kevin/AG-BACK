require "test_helper"

class ModelPicturesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @model_picture = model_pictures(:one)
  end

  test "should get index" do
    get model_pictures_url, as: :json
    assert_response :success
  end

  # test "should create model_picture" do
  #   assert_difference('ModelPicture.count') do
  #     post model_pictures_url, params: { model_picture: { main_picture: @model_picture.main_picture, model_uuid: @model_picture.model_uuid, picture_path: @model_picture.picture_path } }, as: :json
  #   end

  #   assert_response 201
  # end

  test "should show model_picture" do
    get model_picture_url(@model_picture), as: :json
    assert_response :success
  end

  test "should update model_picture" do
    patch model_picture_url(@model_picture), params: { model_picture: { main_picture: @model_picture.main_picture, model_uuid: @model_picture.model_uuid, picture_path: @model_picture.picture_path } }, as: :json
    assert_response 200
  end

  # test "should destroy model_picture" do
  #   assert_difference('ModelPicture.count', -1) do
  #     delete model_picture_url(@model_picture), as: :json
  #   end

  #   assert_response 204
  # end
end
