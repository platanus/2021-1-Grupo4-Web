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
  ingredient_quantity: 5,
  ingredient_measure: 'Kg'
)

RecipeIngredient.create(
  recipe_id: recipe1.id,
  ingredient_id: huevos.id,
  ingredient_quantity: 3,
  ingredient_measure: 'Kg'
)

RecipeIngredient.create(
  recipe_id: recipe1.id,
  ingredient_id: manjar.id,
  ingredient_quantity: 1,
  ingredient_measure: 'Kg'
)

RecipeIngredient.create(
  recipe_id: recipe2.id,
  ingredient_id: limon.id,
  ingredient_quantity: 5,
  ingredient_measure: 'Unidades'
)

RecipeIngredient.create(
  recipe_id: recipe2.id,
  ingredient_id: mantequilla.id,
  ingredient_quantity: 300,
  ingredient_measure: 'Gr'
)

RecipeIngredient.create(
  recipe_id: recipe2.id,
  ingredient_id: sal.id,
  ingredient_quantity: 300,
  ingredient_measure: 'Gr'
)
