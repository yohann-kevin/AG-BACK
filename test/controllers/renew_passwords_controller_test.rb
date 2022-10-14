require "test_helper"

class RenewPasswordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @renew_password = renew_passwords(:one)
  end

  test "should get index" do
    get renew_passwords_url, as: :json
    assert_response :success
  end

  test "should create renew_password" do
    assert_difference('RenewPassword.count') do
      post renew_passwords_url, params: { renew_password: { active: @renew_password.active, agent_email: @renew_password.agent_email, agent_id: @renew_password.agent_id, secure_id: @renew_password.secure_id } }, as: :json
    end

    assert_response 201
  end

  test "should show renew_password" do
    get renew_password_url(@renew_password), as: :json
    assert_response :success
  end

  test "should update renew_password" do
    patch renew_password_url(@renew_password), params: { renew_password: { active: @renew_password.active, agent_email: @renew_password.agent_email, agent_id: @renew_password.agent_id, secure_id: @renew_password.secure_id } }, as: :json
    assert_response 200
  end

  test "should destroy renew_password" do
    assert_difference('RenewPassword.count', -1) do
      delete renew_password_url(@renew_password), as: :json
    end

    assert_response 204
  end
end
