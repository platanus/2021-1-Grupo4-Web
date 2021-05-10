class Api::V1::IngredientsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, fallback: :exception

  def search_jumbo_ingredients
    result = JumboClient.new.products_by_query(query: search_params[:query])

    respond_with({ data: result })
  end

  def search_lider_ingredients
    result = LiderClient.new.products_by_query(query: search_params[:query])

    respond_with({ data: result })
  end

  def index
    respond_with ingredients
  end

  def show
    respond_with ingredient
  end

  def create
    respond_with ingredients.create!(ingredient_params)
  end

  def update
    respond_with ingredient.update!(ingredient_params)
  end

  def destroy
    respond_with ingredient.destroy!
  end

  private

  def search_params
    params.permit(:query)
  end

  def ingredient
    @ingredient ||= ingredients.find_by!(id: params[:id])
  end

  def ingredients
    @ingredients ||= current_user.ingredients
  end

  def ingredient_params
    params.require(:ingredient).permit(
      :name,
      :sku,
      :price,
      :currency,
      :quantity,
      :measure,
      :provider_id
    )
  end
end
