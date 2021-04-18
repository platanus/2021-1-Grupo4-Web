class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  protect_from_forgery with: :null_session

  include Api::Error

  def create
    user = User.create!(user_params)
    render json: user, serializer: Api::V1::UserSerializer, status: :created
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
