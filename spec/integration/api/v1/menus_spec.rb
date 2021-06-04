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

    def set_recipes_quantities(quantity_for_each)
      existent_menu.menu_recipes.each do |menu_recipe|
        menu_recipe.update!(recipe_quantity: quantity_for_each)
      end
    end

    def set_ingredients_quantities(recipe, quantity_for_each)
      recipe.recipe_ingredients.each do |recipe_ingredient|
        recipe_ingredient.update!(ingredient_quantity: quantity_for_each)
      end
    end

    post 'Reduces inventory' do
      description 'Reduces inventory of ingredients of menu through recipes'
      consumes 'application/json'
      produces 'application/json'

      let(:recipes_quantities) { 3 }
      let(:first_recipe_ingredients_quantities) { 1 }
      let(:second_recipe_ingredients_quantities) { 2 }

      before do
        set_recipes_quantities(recipes_quantities)
        set_ingredients_quantities(first_recipe, first_recipe_ingredients_quantities)
        set_ingredients_quantities(second_recipe, second_recipe_ingredients_quantities)
      end

      response '200', 'reduced inventory of menu' do
        run_test! do
          expect(first_ingredient.reload.inventory).to eq(9)
          expect(second_ingredient.reload.inventory).to eq(7)
          expect(third_ingredient.reload.inventory).to eq(0)
        end
      end
    end
  end
end
# rubocop:enable RSpec/EmptyExampleGroup, RSpec/MultipleMemoizedHelpers, RSpec/ScatteredSetup
