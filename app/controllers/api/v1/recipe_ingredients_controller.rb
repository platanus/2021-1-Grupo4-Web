class Api::V1::RecipeIngredientsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, fallback: :exception
  before_action :verify_owned_ingredient, only: [:create, :update]

  def create
    respond_with recipe_ingredients.create!(recipe_ingredient_params)
  end

  def update
    respond_with recipe_ingredient.update!(recipe_ingredient_params)
  end

  def destroy
    respond_with recipe_ingredient.destroy!
  end

  private

  def recipe_ingredient
    @recipe_ingredient ||= recipe_ingredients.find_by!(id: params[:id])
  end

  def recipe_ingredients
    @recipe_ingredients ||= recipe.recipe_ingredients
  end

  def recipe
    @recipe ||= current_user.recipes.find_by!(id: params[:recipe_id])
  end

  def verify_owned_ingredient
    current_user.ingredients.find_by!(id: recipe_ingredient_params[:ingredient_id])
  end

  def recipe_ingredient_params
    params.require(:recipe_ingredient).permit(
      :recipe_id,
      :ingredient_id,
      :ingredient_quantity,
      :ingredient_measure
    )
  end
end
