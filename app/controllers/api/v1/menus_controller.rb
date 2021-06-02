class Api::V1::MenusController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User
  before_action :verify_owned_recipes, only: [:create, :update]

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
    @menus ||= current_user.menus
  end

  def verify_owned_recipes
    menu_recipes_attributes = menu_params[:menu_recipes_attributes]
    return if menu_recipes_attributes.blank?

    recipe_ids = menu_recipes_attributes.map { |menu_recipe| menu_recipe['recipe_id'] }
    current_user.recipes.find(recipe_ids)
  end

  def menu_params
    params.require(:menu).permit(
      :name,
      menu_recipes_attributes: [:id, :recipe_id, :recipe_quantity, :_destroy]
    )
  end
end
