class Api::V1::MenuRecipesController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, fallback: :exception
  before_action :verify_owned_recipe, only: [:create, :update]

  def create
    respond_with menu_recipes.create!(menu_recipe_params)
  end

  def update
    respond_with menu_recipe.update!(menu_recipe_params)
  end

  def destroy
    respond_with menu_recipe.destroy!
  end

  private

  def menu_recipe
    @menu_recipe ||= menu_recipes.find_by!(id: params[:id])
  end

  def menu_recipes
    @menu_recipes ||= menu.menu_recipes
  end

  def menu
    @menu ||= current_user.menus.find_by!(id: params[:menu_id])
  end

  def verify_owned_recipe
    current_user.recipes.find_by!(id: menu_recipe_params[:recipe_id])
  end

  def menu_recipe_params
    params.require(:menu_recipe).permit(
      :menu_id,
      :recipe_id,
      :recipe_quantity
    )
  end
end
