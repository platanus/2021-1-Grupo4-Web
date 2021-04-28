
recipe_1 = Recipe.first
recipe_2 = Recipe.second

harina = Ingredient.find_by(name: 'Harina')
huevos = Ingredient.find_by(name: 'Huevos')
manjar = Ingredient.find_by(name: 'Manjar')

limon = Ingredient.find_by(name: 'Limón')
mantequilla = Ingredient.find_by(name: 'Mantequilla')
sal = Ingredient.find_by(name: 'Sal')

RecipeIngredient.create(
  recipe_id: recipe_1.id,
  ingredient_id: harina.id
)

RecipeIngredient.create(
  recipe_id: recipe_1.id,
  ingredient_id: huevos.id
)

RecipeIngredient.create(
  recipe_id: recipe_1.id,
  ingredient_id: manjar.id
)

RecipeIngredient.create(
  recipe_id: recipe_2.id,
  ingredient_id: limon.id
)

RecipeIngredient.create(
  recipe_id: recipe_2.id,
  ingredient_id: mantequilla.id
)

RecipeIngredient.create(
  recipe_id: recipe_2.id,
  ingredient_id: sal.id
)
