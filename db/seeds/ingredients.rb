
provider_1 = Provider.first
provider_2 = Provider.second

user_1 = User.first
user_2 = User.second

Ingredient.create(
  provider_id: provider_1.id,
  user_id: user_1.id,
  name: 'Harina',
  sku: '98412312',
  price: 2990,
  currency: 'CLP',
  quantity: 1,
  measure: 'Kg'
)

Ingredient.create(
  provider_id: provider_2.id,
  user_id: user_1.id,
  name: 'Huevos',
  sku: '98417912',
  price: 3990,
  currency: 'CLP',
  quantity: 1,
  measure: 'Unidades'
)

Ingredient.create(
  provider_id: provider_1.id,
  user_id: user_1.id,
  name: 'Manjar',
  sku: '98416584',
  price: 4290,
  currency: 'CLP',
  quantity: 1,
  measure: 'Kg'
)

Ingredient.create(
  provider_id: provider_1.id,
  user_id: user_2.id,
  name: 'Limón',
  sku: '98412812',
  price: 990,
  currency: 'CLP',
  quantity: 4,
  measure: 'Kg'
)

Ingredient.create(
  provider_id: provider_2.id,
  user_id: user_2.id,
  name: 'Mantequilla',
  sku: '98411234',
  price: 2990,
  currency: 'CLP',
  quantity: 1,
  measure: 'Kg'
)

Ingredient.create(
  provider_id: provider_2.id,
  user_id: user_2.id,
  name: 'Sal',
  sku: '98410091',
  price: 1990,
  currency: 'CLP',
  quantity: 1,
  measure: 'Kg'
)
