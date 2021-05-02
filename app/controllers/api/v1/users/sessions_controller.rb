class Api::V1::Users::SessionsController < Devise::SessionsController
  before_action :load_user, only: :create
  protect_from_forgery with: :null_session

  include Api::Error

  def create
    if @user.valid_password?(sign_in_params[:password])
      sign_in @user
      render json: @user, serializer: Api::V1::UserSerializer, status: :ok
    else
      respond_api_error(:unauthorized, { message: 'Invalid email or password' })
    end
  end

  private

  def load_user
    @user = User.find_by!(email: sign_in_params[:email])
  end

  def sign_in_params
    params.require(:user).permit(:email, :password)
  end
end
