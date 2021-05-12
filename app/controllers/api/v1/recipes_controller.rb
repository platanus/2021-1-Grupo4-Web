class Api::V1::RecipesController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, fallback: :exception

  def index
    respond_with recipes
  end

  def show
    respond_with recipe
  end

  def create
    respond_with recipes.create!(recipe_params)
  end

  def update
    respond_with recipe.update!(recipe_params)
  end

  def add_ingredient
    recipe_ingredient = recipe_ingredients.create!(ingredient_params)
    render json: recipe_ingredient, serializer: Api::V1::RecipeIngredientSerializer, status: :ok
  end

  def remove_ingredient
    respond_with recipe_ingredient.destroy!
  end

  def destroy
    respond_with recipe.destroy!
  end

  private

  def recipe
    @recipe ||= recipes.find_by!(id: params[:id])
  end

  def recipes
    @recipes ||= current_user.recipes
  end

  def recipe_ingredients
    @recipe_ingredients ||= recipe.recipe_ingredients
  end

  def recipe_ingredient
    @recipe_ingredient ||= recipe.recipe_ingredients.find_by!(
      ingredient_id: ingredient_params[:ingredient_id]
    )
  end

  def recipe_params
    params.require(:recipe).permit(
      :name,
      :portions,
      :instructions,
      :cook_minutes
    )
  end

  def ingredient_params
    params.permit(:ingredient_id, :ingredient_quantity)
  end
end
