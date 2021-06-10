Provider.create(
  name: 'Lider',
  address: 'Santiago',
  country: 'Chile',
  email: 'contacto@lider.cl',
  phone: '+56 9 62288121',
  delivery_days: 2,
  minimum_purchase: 8_000,
  webpage_url: 'https://jumbo.cl',
  user: User.first
)

Provider.create(
  name: 'Jumbo',
  address: 'Santiago',
  country: 'Chile',
  email: 'contacto@jumbo.cl',
  phone: '+56 9 62288141',
  delivery_days: 1,
  minimum_purchase: 15_000,
  webpage_url: 'https://lider.cl',
  user: User.second
)
