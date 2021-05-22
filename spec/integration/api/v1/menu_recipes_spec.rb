require 'swagger_helper'

# rubocop:disable RSpec/EmptyExampleGroup, RSpec/MultipleMemoizedHelpers
describe 'API::V1::MenuRecipes', swagger_doc: 'v1/swagger.json' do
  let(:user) { create(:user) }
  let(:user_email) { user.email }
  let(:user_token) { user.authentication_token }

  let(:menu) { create(:menu, user: user) }
  let(:recipe) { create(:recipe, user: user) }
  let(:menu_id) { menu.id }

  path '/menus/{menu_id}/menu_recipes' do
    parameter name: :menu_id, in: :path, type: :integer
    parameter name: :user_email, in: :query, type: :string
    parameter name: :user_token, in: :query, type: :string

    post 'Creates Menu Recipe' do
      description 'Creates Menu Recipe'
      consumes 'application/json'
      produces 'application/json'
      parameter(
        name: :menu_recipe,
        in: :body,
        schema: {
          type: "object",
          properties: {
            menu_recipe: { "$ref" => "#/definitions/menu_recipe" }
          },
          required: [
            :menu_recipe
          ]
        }
      )

      response '201', 'menu_recipe created' do
        let(:menu_recipe) do
          {
            recipe_id: recipe.id,
            recipe_quantity: 3
          }
        end

        run_test!
      end

      response '401', 'user unauthorized' do
        let(:menu_recipe) { {} }
        let(:user_token) { 'invalid' }

        run_test!
      end

      response '404', 'recipe not found' do
        let!(:other_user_recipe) { create(:recipe) }
        let(:menu_recipe) do
          {
            recipe_id: other_user_recipe.id,
            recipe_quantity: 3
          }
        end
        let(:recipe_id) { 'invalid' }

        run_test!
      end
    end
  end

  path '/menus/{menu_id}/menu_recipes/{id}' do
    parameter name: :menu_id, in: :path, type: :integer
    parameter name: :user_email, in: :query, type: :string
    parameter name: :user_token, in: :query, type: :string

    parameter name: :id, in: :path, type: :integer

    let(:existent_menu_recipe) do
      create(:menu_recipe, menu: menu, recipe: recipe)
    end
    let(:id) { existent_menu_recipe.id }

    put 'Updates Menu Recipe' do
      description 'Updates Menu Recipe'
      consumes 'application/json'
      produces 'application/json'
      parameter(
        name: :menu_recipe,
        in: :body,
        schema: {
          type: "object",
          properties: {
            menu_recipe: { "$ref" => "#/definitions/menu_recipe" }
          },
          required: [
            :menu_recipe
          ]
        }
      )

      response '200', 'menu_recipe updated' do
        let(:menu_recipe) do
          {
            recipe_id: recipe.id,
            recipe_quantity: 4
          }
        end

        run_test!
      end

      response '401', 'user unauthorized' do
        let(:menu_recipe) { {} }
        let(:user_token) { 'invalid' }

        run_test!
      end
    end

    delete 'Deletes Menu Recipe' do
      produces 'application/json'
      description 'Deletes specific menu_recipe'

      response '204', 'menu_recipe deleted' do
        run_test!
      end

      response '404', 'menu_recipe not found' do
        let(:id) { 'invalid' }

        run_test!
      end

      response '401', 'user unauthorized' do
        let(:user_token) { 'invalid' }

        run_test!
      end
    end
  end
end
# rubocop:enable RSpec/EmptyExampleGroup, RSpec/MultipleMemoizedHelpers
