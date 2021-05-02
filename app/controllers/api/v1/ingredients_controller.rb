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

  def clients
    [JumboClient]
  end

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
