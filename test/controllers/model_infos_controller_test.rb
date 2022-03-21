require "test_helper"

class ModelInfosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @model_info = model_infos(:one)
  end

  test "should get index" do
    get model_infos_url, as: :json
    assert_response :success
  end

  test "should create model_info" do
    assert_difference('ModelInfo.count') do
      post model_infos_url, params: { model_info: { astrological: @model_info.astrological, chest: @model_info.chest, color: @model_info.color, description: @model_info.description, hair_color: @model_info.hair_color, hips: @model_info.hips, model_uuid: @model_info.model_uuid, shoe_size: @model_info.shoe_size, size: @model_info.size, waist: @model_info.waist, weight: @model_info.weight } }, as: :json
    end

    assert_response 201
  end

  test "should show model_info" do
    get model_info_url(@model_info), as: :json
    assert_response :success
  end

  test "should update model_info" do
    patch model_info_url(@model_info), params: { model_info: { astrological: @model_info.astrological, chest: @model_info.chest, color: @model_info.color, description: @model_info.description, hair_color: @model_info.hair_color, hips: @model_info.hips, model_uuid: @model_info.model_uuid, shoe_size: @model_info.shoe_size, size: @model_info.size, waist: @model_info.waist, weight: @model_info.weight } }, as: :json
    assert_response 200
  end

  test "should destroy model_info" do
    assert_difference('ModelInfo.count', -1) do
      delete model_info_url(@model_info), as: :json
    end

    assert_response 204
  end
end
