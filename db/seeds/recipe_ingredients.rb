recipe1 = Recipe.first
recipe2 = Recipe.second

harina = Ingredient.find_by(name: 'Harina')
huevos = Ingredient.find_by(name: 'Huevos')
manjar = Ingredient.find_by(name: 'Manjar')

limon = Ingredient.find_by(name: 'Limón')
mantequilla = Ingredient.find_by(name: 'Mantequilla')
sal = Ingredient.find_by(name: 'Sal')

RecipeIngredient.create(
  recipe_id: recipe1.id,
  ingredient_id: harina.id,
  ingredient_quantity: 1,
  ingredient_measure: 'Kilo'
)

RecipeIngredient.create(
  recipe_id: recipe1.id,
  ingredient_id: huevos.id,
  ingredient_quantity: 1,
  ingredient_measure: 'Kilo'
)

RecipeIngredient.create(
  recipe_id: recipe1.id,
  ingredient_id: manjar.id,
  ingredient_quantity: 1,
  ingredient_measure: 'Unidad'
)

RecipeIngredient.create(
  recipe_id: recipe2.id,
  ingredient_id: limon.id,
  ingredient_quantity: 2,
  ingredient_measure: 'Malla'
)

RecipeIngredient.create(
  recipe_id: recipe2.id,
  ingredient_id: mantequilla.id,
  ingredient_quantity: 300,
  ingredient_measure: 'Gramo'
)

RecipeIngredient.create(
  recipe_id: recipe2.id,
  ingredient_id: sal.id,
  ingredient_quantity: 300,
  ingredient_measure: 'Gramo'
)
