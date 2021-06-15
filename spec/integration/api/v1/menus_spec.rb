require 'swagger_helper'

# rubocop:disable RSpec/EmptyExampleGroup, RSpec/MultipleMemoizedHelpers, RSpec/ScatteredSetup
describe 'Api::V1::Menus', swagger_doc: 'v1/swagger.json' do
  let!(:user) { create(:user) }
  let(:user_email) { user.email }
  let(:user_token) { user.authentication_token }
  let(:user_to_update) { create(:user) }

  path '/menus' do
    parameter name: :user_email, in: :query, type: :string
    parameter name: :user_token, in: :query, type: :string

    get 'Retrieves Menus' do
      description 'Retrieves all the menus'
      produces 'application/json'

      let(:collection_count) { 5 }
      let(:expected_collection_count) { collection_count }

      before { create_list(:menu, collection_count, user: user) }

      response '200', 'Menus retrieved' do
        schema('$ref' => '#/definitions/menus_collection')

        run_test! do |response|
          expect(JSON.parse(response.body)['data'].count).to eq(expected_collection_count)
        end
      end
    end

    post 'Creates Menu' do
      description 'Creates Menu'
      consumes 'application/json'
      produces 'application/json'
      parameter(
        name: :menu,
        in: :body,
        schema: {
          type: "object",
          properties: {
            menu: { "$ref" => "#/definitions/menu" }
          },
          required: [
            :menu
          ]
        }
      )

      response '201', 'menu created' do
        let(:menu) do
          {
            name: 'Some name'
          }
        end

        run_test!
      end

      response '404', 'recipe not of user' do
        let!(:other_user_recipe) { create(:recipe) }
        let(:menu) do
          {
            name: 'Some name',
            menu_recipes_attributes: [
              {
                recipe_id: other_user_recipe.id,
                recipe_quantity: 5
              }
            ]
          }
        end

        run_test!
      end
    end
  end

  path '/menus/{id}' do
    parameter name: :id, in: :path, type: :integer
    parameter name: :user_email, in: :query, type: :string
    parameter name: :user_token, in: :query, type: :string

    let(:existent_menu) { create(:menu, user: user) }
    let(:id) { existent_menu.id }

    get 'Retrieves Menu' do
      produces 'application/json'

      response '200', 'menu retrieved' do
        schema('$ref' => '#/definitions/menu_resource')

        run_test!
      end

      response '404', 'invalid menu id' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    put 'Updates Menu' do
      description 'Updates Menu'
      consumes 'application/json'
      produces 'application/json'
      parameter(
        name: :menu,
        in: :body,
        schema: {
          type: "object",
          properties: {
            menu: { "$ref" => "#/definitions/menu_update" }
          },
          required: [
            :menu
          ]
        }
      )

      response '200', 'menu updated' do
        let(:menu) do
          {
            name: 'Some other name'
          }
        end

        run_test!
      end
    end

    delete 'Deletes Menu' do
      produces 'application/json'
      description 'Deletes specific menu'

      response '204', 'menu deleted' do
        run_test!
      end

      response '404', 'menu not found' do
        let(:id) { 'invalid' }

        run_test!
      end
    end
  end

  path '/menus/{id}/reduce-inventory' do
    parameter name: :id, in: :path, type: :integer
    parameter name: :user_email, in: :query, type: :string
    parameter name: :user_token, in: :query, type: :string

    let!(:first_ingredient) { create(:ingredient, inventory: 12) }
    let!(:second_ingredient) { create(:ingredient, inventory: 10) }
    let!(:third_ingredient) { create(:ingredient, inventory: 2) }
    let!(:first_recipe) { create(:recipe, ingredients: [first_ingredient, second_ingredient]) }
    let!(:second_recipe) { create(:recipe, ingredients: [third_ingredient]) }
    let!(:existent_menu) { create(:menu, recipes: [first_recipe, second_recipe], user: user) }
    let(:id) { existent_menu.id }

    post 'Reduces inventory' do
      description 'Reduces inventory of ingredients of menu through recipes'
      consumes 'application/json'
      produces 'application/json'

      # rubocop:disable Rails/SkipsModelValidations
      before do
        existent_menu.menu_recipes.update_all(recipe_quantity: 3)
        first_recipe.recipe_ingredients.update_all(ingredient_quantity: 1)
        second_recipe.recipe_ingredients.update_all(ingredient_quantity: 2)
      end
      # rubocop:enable Rails/SkipsModelValidations

      response '200', 'reduced inventory of menu' do
        run_test! do
          expect(first_ingredient.reload.inventory).to eq(9)
          expect(second_ingredient.reload.inventory).to eq(7)
          expect(third_ingredient.reload.inventory).to eq(0)
        end
      end
    end
  end

  path '/menus/{id}/shopping-list' do
    parameter name: :id, in: :path, type: :integer
    parameter name: :user_email, in: :query, type: :string
    parameter name: :user_token, in: :query, type: :string

    let!(:provider) { create(:provider, name: 'Jumbo', user: user) }
    let!(:first_ingredient) { create(:ingredient, name: "First", provider: provider, user: user) }
    let!(:second_ingredient) { create(:ingredient, name: "Second", provider: provider, user: user) }
    let!(:third_ingredient) { create(:ingredient, name: "Third", provider: provider, user: user) }
    let!(:first_recipe) do
      create(:recipe, user: user)
    end
    let!(:second_recipe) do
      create(:recipe, user: user)
    end
    let!(:existent_menu) { create(:menu, recipes: [first_recipe, second_recipe], user: user) }
    let(:id) { existent_menu.id }

    def ingredient_hash(name, quantity)
      hash_including(
        measure: kind_of(String), name: name,
        quantity: quantity, total_price: kind_of(Integer)
      )
    end

    let(:expected_response) do
      {
        provider: "Jumbo",
        ingredients: match_array([
                                   ingredient_hash("First", 9),
                                   ingredient_hash("Second", 30),
                                   ingredient_hash("Third", 6)
                                 ])
      }
    end

    get 'Returns Menu Ingredients, same as shopping list' do
      description 'Get ingredients of a menu with quantities, prices, measures grouped by provider'
      consumes 'application/json'
      produces 'application/json'

      # rubocop:disable Rails/SkipsModelValidations
      before do
        existent_menu.menu_recipes.update_all(recipe_quantity: 3)

        first_recipe.recipe_ingredients.create(
          ingredient: first_ingredient, ingredient_quantity: 3, ingredient_measure: 'Kg'
        )
        first_recipe.recipe_ingredients.create(
          ingredient: second_ingredient, ingredient_quantity: 5, ingredient_measure: 'L'
        )

        second_recipe.recipe_ingredients.create(
          ingredient: second_ingredient, ingredient_quantity: 5, ingredient_measure: 'L'
        )
        second_recipe.recipe_ingredients.create(
          ingredient: third_ingredient, ingredient_quantity: 2, ingredient_measure: 'Unidades'
        )

        IngredientMeasure.create!(name: 'Kg', quantity: 3, ingredient_id: first_ingredient.id)
        IngredientMeasure.create!(name: 'L', quantity: 5, ingredient_id: second_ingredient.id)
        IngredientMeasure.create!(name: 'Unidades', quantity: 2, ingredient_id: third_ingredient.id)
      end
      # rubocop:enable Rails/SkipsModelValidations

      response '200', 'shopping list grouped by provider' do
        run_test! do |response|
          expect(JSON.parse(response.body).first.deep_symbolize_keys).to match(expected_response)
        end
      end
    end
  end
end
# rubocop:enable RSpec/EmptyExampleGroup, RSpec/MultipleMemoizedHelpers, RSpec/ScatteredSetup
