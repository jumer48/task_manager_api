require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    # Create user with guaranteed unique email
    User.create!(
      email: "test#{SecureRandom.hex}@example.com",
      password: "password123"
    )

    get users_url
    assert_response :success
  end
end
