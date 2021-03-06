class Api::V1::MenusController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, fallback: :exception
  before_action :verify_owned_recipes, only: [:create, :update]

  def index
    respond_with menus.order(:name)
  end

  def show
    respond_with menu
  end

  def create
    respond_with menus.create!(menu_params)
  end

  def update
    respond_with menu.update!(menu_params)
  end

  def destroy
    respond_with menu.destroy!
  end

  def reduce_inventory
    menu_recipes_ingredients_to_reduce_inventory.each do |record|
      ingredient = Ingredient.find(record.ingredient_id)
      ingredient_quantity = ingredient.factor_of_default_quantity_by_measure(
        record.ingredient_measure
      ) * record.ingredient_quantity.to_f
      quantity_to_decrement = record.recipe_quantity.to_i * ingredient_quantity

      ingredient.decrement_inventory!(quantity_to_decrement)
    end

    render json: {}, status: :ok
  end

  def shopping_list
    respond_with shopping_list_as_json
  end

  def download_shopping_list
    file_stream = ::GenerateShoppingListFile.for(shopping_list_json: shopping_list_as_json)

    send_data file_stream, filename: 'shopping-list.xlsx'
  end

  private

  def menu
    @menu ||= menus.find_by!(id: params[:id])
  end

  def menus
    @menus ||= current_user.menus
  end

  def verify_owned_recipes
    menu_recipes_attributes = menu_params[:menu_recipes_attributes]
    return if menu_recipes_attributes.blank?

    recipe_ids = menu_recipes_attributes.map { |menu_recipe| menu_recipe['recipe_id'] }
    current_user.recipes.find(recipe_ids)
  end

  def shopping_list_as_json
    shopping_list_ingredients = Hash.new(0)
    menu_ingredients_with_providers_and_quantities.each do |record|
      shopping_list_ingredients[record] += menu_ingredient_quantity(record)
    end

    providers_with_ingredients = Hash.new { |h, k| h[k] = [] }
    shopping_list_ingredients.each do |ingredient, accumulated_quantity|
      provider_name = ingredient.provider.blank? ? 'Sin proveedor' : ingredient.provider.name
      providers_with_ingredients[provider_name] << menu_ingredient_to_json(
        ingredient: ingredient, accumulated_quantity: accumulated_quantity
      )
    end

    format_providers_with_ingredients(providers_with_ingredients)
  end

  def menu_recipes_ingredients_to_reduce_inventory
    menu.menu_recipes.joins(
      recipe: { recipe_ingredients: :ingredient }
    ).select(
      'ingredients.id as ingredient_id,
       menu_recipes.recipe_quantity as recipe_quantity,
       recipe_ingredients.ingredient_quantity as ingredient_quantity,
       recipe_ingredients.ingredient_measure as ingredient_measure'
    )
  end

  def menu_ingredients_with_providers_and_quantities
    Ingredient.joins(
      recipe_ingredients: { recipe: { menu_recipes: :menu } }
    ).where('menus.id = ?', menu.id).select(
      'menu_recipes.recipe_quantity as recipe_quantity,
       recipe_ingredients.ingredient_quantity as ingredient_quantity,
       recipe_ingredients.ingredient_measure as ingredient_measure,
       ingredients.*'
    ).includes(:provider)
  end

  def menu_ingredient_to_json(ingredient:, accumulated_quantity:)
    {
      name: ingredient.name,
      measure: ingredient.measure,
      quantity: accumulated_quantity.round(2),
      inventory: ingredient.inventory,
      total_price: (ingredient.price.to_f / ingredient.quantity * accumulated_quantity).round(2)
    }
  end

  def format_providers_with_ingredients(providers_with_ingredients)
    providers_with_ingredients.map do |provider, ingredients|
      {
        provider: provider,
        ingredients: ingredients
      }
    end
  end

  def menu_ingredient_quantity(record)
    ingredient_quantity = record.factor_of_default_quantity_by_measure(
      record.ingredient_measure
    ) * record.ingredient_quantity.to_f

    record.recipe_quantity.to_f * ingredient_quantity
  end

  def menu_params
    params.require(:menu).permit(
      :name,
      :portions,
      menu_recipes_attributes: [:id, :recipe_id, :recipe_quantity, :_destroy]
    )
  end
end
