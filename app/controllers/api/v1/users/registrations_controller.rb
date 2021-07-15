class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  protect_from_forgery with: :null_session
  acts_as_token_authentication_handler_for User, fallback: :exception, only: [:change_password]

  self.responder = ApiResponder
  respond_to :json

  include Api::Error

  def create
    user = User.create!(user_params)
    sign_in user

    render json: user, serializer: Api::V1::UserSerializer, status: :created
  end

  def change_password
    if current_user.present?
      resetted = current_user.reset_password(
        change_password_params[:password],
        change_password_params[:password_confirmation]
      )

      return respond_api_error(:bad_request, message: 'reset password error') unless resetted

      bypass_sign_in(current_user)
      sign_in current_user

      render json: current_user, serializer: Api::V1::UserSerializer, status: :ok
    else
      respond_api_error(:unauthorized, { message: 'User not logged in' })
    end
  end

  def forgot_password
    user_email = forgot_password_params[:email]

    respond_with begin
      User.find_by!(email: user_email).send_reset_password_instructions

      true
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def change_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def forgot_password_params
    params.require(:user).permit(:email)
  end
end
