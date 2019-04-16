class V1::SessionsController < ApplicationController
  
  def create
    user = User.find_by_email(params[:email])
    if user.valid_password?(params[:password]) && user.confirmed_at.present?
      render json: {message: "User authenticated successfully"}, status: :ok
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
