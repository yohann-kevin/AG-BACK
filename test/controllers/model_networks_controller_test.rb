require "test_helper"

class ModelNetworksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @model_network = model_networks(:one)
  end

  test "should get index" do
    get model_networks_url, as: :json
    assert_response :success
  end

  test "should create model_network" do
    assert_difference('ModelNetwork.count') do
      post model_networks_url, params: { model_network: { facebook: @model_network.facebook, instagram: @model_network.instagram, model_uuid: @model_network.model_uuid, snapchat: @model_network.snapchat, tiktok: @model_network.tiktok, twitter: @model_network.twitter } }, as: :json
    end

    assert_response 201
  end

  test "should show model_network" do
    get model_network_url(@model_network), as: :json
    assert_response :success
  end

  test "should update model_network" do
    patch model_network_url(@model_network), params: { model_network: { facebook: @model_network.facebook, instagram: @model_network.instagram, model_uuid: @model_network.model_uuid, snapchat: @model_network.snapchat, tiktok: @model_network.tiktok, twitter: @model_network.twitter } }, as: :json
    assert_response 200
  end

  test "should destroy model_network" do
    assert_difference('ModelNetwork.count', -1) do
      delete model_network_url(@model_network), as: :json
    end

    assert_response 204
  end
end
