class Api::V1::RecipesController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, fallback: :exception

  def index
    respond_with Recipe.all
  end

  def show
    respond_with recipe
  end

  def create
    respond_with Recipe.create!(recipe_params)
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

  def recipe_params
    params.require(:recipe).permit(
      :user_id,
      :name,
      :portions,
      :instructions,
      :cook_minutes
    )
  end
end
