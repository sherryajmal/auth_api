require 'test_helper'

class UsersSigninTest < ActionDispatch::IntegrationTest
  test "invalid signin information" do
  	post v1_sessions_path, params: {email: "", password: ""}
  end

  test "valid signin information" do
  	post v1_sessions_path, params: {email: "umersidhu876@gmail.com", password: "123456"}
  end
end
