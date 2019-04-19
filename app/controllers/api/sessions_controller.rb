class Api::SessionsController < ApplicationController
  before_action :authenticate, only: [:sign_out, :update_profile]
  def create
    user = User.find_by_email(params[:email])
    if user.valid_password?(params[:password]) && user.confirmed_at.present?
      user.update(authentication_token: Devise.friendly_token)
      data = user.as_json(only: [:id, :email, :confirmed_at, :created_at, :updated_at, :authentication_token])
      data.merge!(message: "User authenticated successfully")
      render json: data, status: :authenticated
    else
      render json: {message: "User is not authenticated"}, status: :error
    end
  end

  def show
    user = User.find params[:id]
    data = user.as_json(only: [:id, :email, :confirmed_at, :created_at, :updated_at, :authentication_token])
    render json: data, status: :authenticated
  end

  # DELETE /resource/sign_out
  def sign_out
    user = User.find_by(authentication_token: params[:authentication_token])
    if user.present?
      if user.update(authentication_token: nil)
        render json: {message: "user successfully logged out"}
      else
        head(:unauthorized)
      end
    else
      render json: { message: "You need to signin or signup"}
    end  
  end

  def update_profile
    user = User.find_by(authentication_token: params[:authentication_token])
    if user.present?
      if user.valid_password?(params[:old_password])
         user.email = params[:email] if params[:email].present?
         user.password =  params[:new_password]
        if user.save!
          render json: {message: "Profile updated"}
        else
          head(:unprocessable_entity)
        end
      else
        head(:unauthorized)
      end
    else
      render json: { message: "You need to signin to update profile"}
    end
  end
end
