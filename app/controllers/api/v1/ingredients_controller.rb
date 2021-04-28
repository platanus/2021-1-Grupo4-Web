class Api::V1::IngredientsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, fallback: :exception

  def search_ingredients
    base_result = []
    clients.each do |client|
      base_result += client.new.products_by_query(query: search_params[:query])
    end

    respond_with({ data: base_result })
  end

  def index
    respond_with Ingredient.where(user_id: current_user.id)
  end

  def show
    respond_with ingredient
  end

  def create
    respond_with Ingredient.create!(ingredient_params.merge(user_id: current_user.id))
  end

  def update
    respond_with ingredient.update!(ingredient_params.merge(user_id: current_user.id))
  end

  def destroy
    respond_with ingredient.destroy!
  end

  private

  def clients
    [JumboClient]
  end

  def search_params
    params.permit(:query)
  end

  def ingredient
    @ingredient ||= Ingredient.find_by!(id: params[:id], user_id: current_user.id)
  end

  def ingredient_params
    params.require(:ingredient).permit(
      :provider_id,
      :name,
      :sku,
      :price,
      :currency,
      :quantity,
      :measure
    )
  end
end
