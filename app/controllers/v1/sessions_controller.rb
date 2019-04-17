class V1::SessionsController < ApplicationController
  
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

  # DELETE /resource/sign_out
  def destroy
    user = User.find params[:id]
    if user.update(authentication_token: nil)
      head(:ok)
    else
      head(:unauthorized)
    end
  end

  def update
    @user = User.find params[:id]
    if @user.valid_password?(params[:old_password])
       @user.email = params[:email] if params[:email].present?
       @user.password =  params[:new_password]
      if @user.save!
        render json: {message: "password updated"}
      else
        head(:unprocessable_entity)
      end
    else
      head(:unauthorized)
    end
  end
end
