class Api::V1::RecipeStepsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, fallback: :exception

  def create
    respond_with recipe_steps.create!(recipe_step_params)
  end

  def update
    respond_with recipe_step.update!(recipe_step_params)
  end

  def destroy
    respond_with recipe_step.destroy!
  end

  private

  def recipe_step
    @recipe_step ||= recipe_steps.find_by!(id: params[:id])
  end

  def recipe_steps
    @recipe_steps ||= recipe.steps
  end

  def recipe
    @recipe ||= recipes.find_by!(id: params[:recipe_id])
  end

  def recipes
    @recipes ||= current_user.recipes
  end

  def recipe_step_params
    params.require(:recipe_step).permit(
      :number,
      :description,
      :media_url,
      :recipe_id
    )
  end
end
