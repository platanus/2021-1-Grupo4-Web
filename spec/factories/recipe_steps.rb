FactoryBot.define do
  factory :recipe_step do
    description { "Algún paso de receta" }
    media_url { "https://url-to-media.com" }
    recipe { create(:recipe) }
  end
end
