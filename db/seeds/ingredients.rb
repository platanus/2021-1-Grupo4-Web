provider1 = Provider.first
provider2 = Provider.second

user1 = User.first
user2 = User.second

Ingredient.create(
  provider_id: provider1.id,
  user_id: user1.id,
  name: 'Harina',
  sku: '98412312',
  price: 2990,
  currency: 'CLP',
  ingredient_measures_attributes: [
    { name: 'Kilo', quantity: 1 }
  ]
)

Ingredient.create(
  provider_id: provider2.id,
  user_id: user1.id,
  name: 'Huevos',
  sku: '98417912',
  price: 3990,
  currency: 'CLP',
  ingredient_measures_attributes: [
    { name: 'Kilo', quantity: 1 }
  ]
)

Ingredient.create(
  provider_id: provider1.id,
  user_id: user1.id,
  name: 'Manjar',
  sku: '98416584',
  price: 4290,
  currency: 'CLP',
  ingredient_measures_attributes: [
    { name: 'Unidad', quantity: 1 }
  ]
)

Ingredient.create(
  provider_id: provider1.id,
  user_id: user2.id,
  name: 'Limón',
  sku: '98412812',
  price: 990,
  currency: 'CLP',
  ingredient_measures_attributes: [
    { name: 'Malla', quantity: 1 },
    { name: 'Kilo', quantity: 1 }
  ]
)

Ingredient.create(
  provider_id: provider2.id,
  user_id: user2.id,
  name: 'Mantequilla',
  sku: '98411234',
  price: 2990,
  currency: 'CLP',
  ingredient_measures_attributes: [
    { name: 'Gramo', quantity: 300 }
  ]
)

Ingredient.create(
  provider_id: provider2.id,
  user_id: user2.id,
  name: 'Sal',
  sku: '98410091',
  price: 1990,
  currency: 'CLP',
  ingredient_measures_attributes: [
    { name: 'Gramo', quantity: 300 }
  ]
)
