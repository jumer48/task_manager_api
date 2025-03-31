require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    User.create(email: "test@example.com", password: "securepassword")
    get users_url
    assert_response :success
  end
end
