require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  test "should get index" do
    user = User.create(email: "test@example.com", password: "securepassword")
    sign_in user
    get users_url
    assert_response :success
  end
end
