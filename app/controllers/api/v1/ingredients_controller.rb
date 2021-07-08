class Api::V1::IngredientsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, fallback: :exception

  def search_jumbo_products(message: nil)
    result = JumboClient.new.products_by_query(query: search_params[:query])

    respond_with({ data: result, message: message })
  rescue StandardError
    respond_with({ data: [], message: I18n.t('alerts.scraper-failed') })
  end

  def search_lider_products(message: nil)
    result = LiderClient.new.products_by_query(query: search_params[:query])

    respond_with({ data: result, message: message })
  rescue StandardError
    search_jumbo_products(message: I18n.t('alerts.scraper'))
  end

  def search_cornershop_products(message: nil)
    result = CornershopClient.new.products_by_query(query: search_params[:query])

    respond_with({ data: result, message: message })
  rescue StandardError
    search_lider_products(message: I18n.t('alerts.scraper'))
  end

  def minimum_alert_index
    respond_with ingredients.below_minimum
  end

  def index
    respond_with ingredients
  end

  def show
    respond_with ingredient
  end

  def critical_associations
    respond_with critical_ingredient_associations
  end

  def create
    provider = Provider.find_or_create_by(
      name: ingredient_params[:provider_name], user: current_user
    )

    respond_with ingredients.create!(
      ingredient_params.except(:provider_name).merge(provider_id: provider.id)
    )
  end

  def update_inventories
    respond_with begin
      update_inventories_params.each do |info|
        ingredients.find(info[:ingredient_id]).update!(inventory: info[:inventory])
      end
    end
  end

  def update
    if ingredient_params[:provider_name].blank?
      respond_with ingredient.update!(ingredient_params.except(:provider_name))
    else
      provider = Provider.find_or_create_by(
        name: ingredient_params[:provider_name], user: current_user
      )

      respond_with ingredient.update!(
        ingredient_params.except(:provider_name).merge(provider_id: provider.id)
      )
    end
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

  def critical_ingredient_associations
    {
      recipes: ingredient.recipes
    }
  end

  def ingredient_params
    params.require(:ingredient).permit(
      :name,
      :sku,
      :price,
      :currency,
      :inventory,
      :provider_name,
      :minimum_quantity,
      ingredient_measures_attributes: [:id, :name, :quantity, :primary, :_destroy]
    )
  end

  def update_inventories_params
    params.require(:ingredients)
  end
end
