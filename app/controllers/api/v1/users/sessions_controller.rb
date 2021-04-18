class Api::V1::Users::SessionsController < Devise::SessionsController
  before_action :sign_in_params, only: :create
  before_action :load_user, only: :create
  protect_from_forgery with: :null_session

  def create
    if @user.valid_password?(sign_in_params[:password])
      sign_in @user
      render json: {
        messages: "Signed in",
        is_success: true,
        data: { user: @user }
      }, status: :ok
    else
      render json: { messages: 'Invalid email or password' }, status: :unauthorized
    end
  end

  private

  def sign_in_params
    params.require(:user).permit :email, :password
  end

  def load_user
    @user = User.find_for_database_authentication(email: sign_in_params[:email])
    return @user if @user.present?

    render json: { messages: "Can't find user" }, status: :failure
  end
end
