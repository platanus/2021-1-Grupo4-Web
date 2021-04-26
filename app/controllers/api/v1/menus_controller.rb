class Api::V1::MenusController < Api::V1::BaseController
  
  acts_as_token_authentication_handler_for User

  def index
    respond_with menus
  end

  def show
    respond_with menu
  end

  def create
    respond_with menus.create!(menu_params)
  end

  def update
    respond_with menu.update!(menu_params)
  end

  def destroy
    respond_with menu.destroy!
  end

  private

  def menu
    @menu ||= Menu.find_by!(id: params[:id])
  end

  def menus
    @menus ||= user.menus
  end

  def user
    @user ||= User.find_by!(id: params[:user_id])
  end

  def menu_params
    params.require(:menu).permit(
      :user_id,
      :name
    )
  end
end
