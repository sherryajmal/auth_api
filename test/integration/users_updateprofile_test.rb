require 'test_helper'

class UsersUpdateprofileTest < ActionDispatch::IntegrationTest
  test "invalid updateprofile information" do
    patch update_profile_api_v1_sessions_path, params: {authentication_token: "17f3RY5mHs5jrK3JvYJx", old_password: '123456', new_password: '12341234', email: 'umersidhu876@gmail.com'}
  end

  test "valid updateprofile information" do
    patch update_profile_api_v1_sessions_path, params: {authentication_token: "17f3RY5mHs5jrK3JvYJx", old_password: '', new_password: '12341234', email: 'umersidhu876@gmail.com'}
  end
end
