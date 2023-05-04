require "test_helper"

class ContactsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @contact = contacts(:one)
  end

  test "should get index" do
    get contacts_url, as: :json
    assert_response :success
  end

  test "should create contact" do
    ENV["MAIL_DESTINATOR"] = "test@example.com"

    contact_data = {
      content: "test content",
      destinator: nil,
      object: "test object",
      sender: "test@example.com"
    }

    assert_nothing_raised do
      post contacts_url, params: contact_data, as: :json
    end

    assert_response :created
    assert_equal "test@example.com", Contact.last.destinator
  end

  test "should show contact" do
    get contact_url(@contact), as: :json
    assert_response :success
  end

  test "should update contact" do
    patch contact_url(@contact), params: { contact: { content: @contact.content, destinator: @contact.destinator, object: @contact.object, sender: @contact.sender } }, as: :json
    assert_response 200
  end

  test "should destroy contact" do
    assert_difference('Contact.count', -1) do
      delete contact_url(@contact), as: :json
    end

    assert_response 204
  end
end
