class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  acts_as_token_authentication_handler_for User, fallback: :exception, only: [:change_password]
  protect_from_forgery with: :null_session

  self.responder = ApiResponder
  respond_to :json

  include Api::Error

  def create
    user = User.create!(user_params)
    sign_in user

    render json: user, serializer: Api::V1::UserSerializer, status: :created
  end

  def change_password
    if current_user.valid_password?(change_password_params[:old_password])
      respond_with current_user.update!(change_password_params.except(:old_password))
    else
      respond_api_error(:unauthorized, { message: 'Invalid old password' })
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def change_password_params
    params.require(:user).permit(:old_password, :password, :password_confirmation)
  end
end
