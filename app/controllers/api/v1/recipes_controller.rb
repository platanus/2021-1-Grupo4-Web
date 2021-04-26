class Api::V1::RecipesController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User
  
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
    @recipe ||= Recipe.find_by!(id: params[:id])
  end

  def recipes
    @recipes ||= user.recipes
  end

  def user
    @user ||= User.find_by!(id: params[:user_id])
  end

  def recipe_params
    params.require(:recipe).permit(
      :name,
      :portions,
      :instructions,
      :cook_minutes
    )
  end
end
