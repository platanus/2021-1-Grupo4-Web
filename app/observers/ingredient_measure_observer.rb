class IngredientMeasureObserver < PowerTypes::Observer
  before_save do
    object.name.capitalize!
    update_recipe_ingredient_if_exists
  end

  before_destroy :change_recipe_ingredient_if_exists

  def update_recipe_ingredient_if_exists
    object.ingredient.recipe_ingredients.each do |recipe_ingredient|
      next unless recipe_ingredient.ingredient_measure == object.name_was

      recipe_ingredient.update!(ingredient_measure: object.name)
    end
  end

  def change_recipe_ingredient_if_exists
    object.ingredient.recipe_ingredients.each do |recipe_ingredient|
      next unless recipe_ingredient.ingredient_measure == object.name_was

      replacing_measure = object.ingredient.default_measure
      name = replacing_measure.name
      quantity = recipe_ingredient.ingredient_quantity / object.quantity_was *
        replacing_measure.quantity
      recipe_ingredient.update!(ingredient_measure: name, ingredient_quantity: quantity)
    end
  end
end
