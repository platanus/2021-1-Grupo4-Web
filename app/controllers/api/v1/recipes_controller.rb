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

  def recipe_params
    params.require(:recipe).permit(
      :name,
      :portions,
      :cook_minutes,
      recipe_ingredients_attributes: [:id, :ingredient_id,
                                      :ingredient_quantity, :ingredient_measure, :_destroy],
      steps_attributes: [:id, :step_order_position, :description, :media_url, :_destroy]
    )
  end
end
