require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "valid signup information" do
    user = User.new(
      email: "abc@gmail.com",
      password: "123456"
    )
    user.save!
  end

  test "invalid signup information" do
    post v1_user_registration_path
  	post v1_user_registration_path, params: { email: "user@invalid", password: "foo", password_confirmation: "bar" }
  end

end