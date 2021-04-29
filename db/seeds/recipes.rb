
user_1 = User.first
user_2 = User.second

Recipe.create(
  user_id: user_1.id,
  name: 'Panqueques',
  portions: 8,
  instructions: 'Junta todos los ingredientes hasta conseguir un atido homogéneo, 
  luego vaya vertiendo porciones en un sartén. Finalmente, añada manjar',
  cook_minutes: 30
)

Recipe.create(
  user_id: user_2.id,
  name: 'Pie de limón',
  portions: 10,
  instructions: 'Las instrucciones para hacer pie de limón son las siguientes...',
  cook_minutes: 45
)
