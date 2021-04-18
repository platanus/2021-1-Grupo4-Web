class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  before_action :ensure_params_exist, only: :create
  skip_before_action :verify_authenticity_token, only: :create

  def create
    user = User.new(user_params)
    if user.save
      render json: {
        message: "Sign up succesfuly",
        user: user
      }, status: :created
    else
      render json: {
        messages: user.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def ensure_params_exist
    return if params[:user].present?

    render json: { message: "Missing params" }, status: :bad_request
  end
end
