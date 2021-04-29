
menu_1 = Menu.first
menu_2 = Menu.second

recipe_1 = Recipe.first
recipe_2 = Recipe.second

MenuRecipe.create(
  menu_id: menu_1.id,
  recipe_id: recipe_1.id,
  recipe_quantity: 2
)

MenuRecipe.create(
  menu_id: menu_2.id,
  recipe_id: recipe_2.id,
  recipe_quantity: 3
)
