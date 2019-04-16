require 'test_helper'

class PasswordConfirmationTest < ActionDispatch::IntegrationTest
  
  test "password confirmation" do
    get v1_user_confirmation_path
  	get v1_user_confirmation_path, params: { confirmation_token: "46543435das3dad" }
  end

  test "invalid password confirmation" do
    get v1_user_confirmation_path
  	get v1_user_confirmation_path, params: { confirmation_token: "" }
  end

end
