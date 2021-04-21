FactoryBot.define do
  factory :recipe do
<<<<<<< HEAD
    name { "Some recipe name" }
    portions { 1 }
    instructions { "Some long instructions for the recipe" }
    cook_minutes { 60 }
=======
    name { "MyString" }
    portions { "" }
    instructions { "MyText" }
    cook_minutes { "MyString" }
    int { "MyString" }
>>>>>>> ce2d487 (feat(crud): create models Recipe RecipeIngredients Menu)
  end
end
