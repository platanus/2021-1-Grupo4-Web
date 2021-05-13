
user_1 = User.first
user_2 = User.second

Recipe.create(
  user_id: user_1.id,
  name: 'Panqueques',
  portions: 8,
  cook_minutes: 30
)

Recipe.create(
  user_id: user_2.id,
  name: 'Pie de limón',
  portions: 10,
  cook_minutes: 45
)
