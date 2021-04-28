
user_1 = User.first
user_2 = User.second

Menu.create(
  user_id: user_1.id,
  name: 'Menu 1'
)

Menu.create(
  user_id: user_2.id,
  name: 'Menu 2'
)
