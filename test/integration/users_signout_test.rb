require 'test_helper'

class UsersSignoutTest < ActionDispatch::IntegrationTest
  test "invalid signout information" do
    delete sign_out_api_sessions_path, params: {authentication_token: ""}
  end

  test "valid signin information" do
    delete sign_out_api_sessions_path, params: {authentication_token: "17f3RY5mHs5jrK3JvYJx"}
  end
end
