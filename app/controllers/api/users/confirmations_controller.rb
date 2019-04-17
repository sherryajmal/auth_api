# frozen_string_literal: true

class Api::Users::ConfirmationsController < Devise::ConfirmationsController
  # GET /resource/confirmation/new
  # def new
  #   super
  # end

  # POST /resource/confirmation
  # def create
  #   super
  # end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    user = User.find_by_confirmation_token(params[:confirmation_token])
    if user.present?
      if user.confirmed_at.blank?
        user.update(confirmed_at: Time.now)
        data = user.as_json(only: [:id, :email, :confirmed_at, :created_at, :updated_at])
        data.merge!(message: "User has been successfully confirmed their email")
        render json: data, status: :confirmed
      else
        data = user.as_json(only: [:id, :email, :confirmed_at, :created_at, :updated_at])
        data.merge!(message: "User has already confirmed their email")
        render json: data, status: :already_confirmed
      end
    else
      render json: {message: "invalid confirmation token or expired confirmation token "}, status: :error
    end
  end

  # protected

  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  # The path used after confirmation.
  # def after_confirmation_path_for(resource_name, resource)
  #   super(resource_name, resource)
  # end
end
