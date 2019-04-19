class ApplicationController < ActionController::API

  def authenticate
    user = User.find_by(authentication_token: params[:authentication_token])
  end
end
