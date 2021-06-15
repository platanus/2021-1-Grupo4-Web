provider1 = Provider.first
provider2 = Provider.second

user1 = User.first
user2 = User.second

ingredient1 = Ingredient.create(
  provider_id: provider1.id,
  user_id: user1.id,
  name: 'Harina',
  sku: '98412312',
  price: 2990,
  currency: 'CLP'
)

ingredient2 = Ingredient.create(
  provider_id: provider2.id,
  user_id: user1.id,
  name: 'Huevos',
  sku: '98417912',
  price: 3990,
  currency: 'CLP'
)

ingredient3 = Ingredient.create(
  provider_id: provider1.id,
  user_id: user1.id,
  name: 'Manjar',
  sku: '98416584',
  price: 4290,
  currency: 'CLP'
)

ingredient4 = Ingredient.create(
  provider_id: provider1.id,
  user_id: user2.id,
  name: 'Limón',
  sku: '98412812',
  price: 990,
  currency: 'CLP'
)

ingredient5 = Ingredient.create(
  provider_id: provider2.id,
  user_id: user2.id,
  name: 'Mantequilla',
  sku: '98411234',
  price: 2990,
  currency: 'CLP'
)

ingredient6 = Ingredient.create(
  provider_id: provider2.id,
  user_id: user2.id,
  name: 'Sal',
  sku: '98410091',
  price: 1990,
  currency: 'CLP'
)

IngredientMeasure.create(
  ingredient_id: ingredient1.id,
  name: 'Kg',
  quantity: 1
)

IngredientMeasure.create(
  ingredient_id: ingredient2.id,
  name: 'Kg',
  quantity: 1
)

IngredientMeasure.create(
  ingredient_id: ingredient3.id,
  name: 'Unidades',
  quantity: 1
)

IngredientMeasure.create(
  ingredient_id: ingredient4.id,
  name: 'Mallas',
  quantity: 2
)

IngredientMeasure.create(
  ingredient_id: ingredient4.id,
  name: 'Kg',
  quantity: 1
)

IngredientMeasure.create(
  ingredient_id: ingredient5.id,
  name: 'Gr',
  quantity: 300
)

IngredientMeasure.create(
  ingredient_id: ingredient6.id,
  name: 'Gr',
  quantity: 300
)
