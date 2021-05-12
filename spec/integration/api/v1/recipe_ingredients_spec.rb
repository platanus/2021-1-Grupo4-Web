require 'swagger_helper'

# rubocop:disable RSpec/EmptyExampleGroup, RSpec/MultipleMemoizedHelpers
describe 'API::V1::RecipeIngredients', swagger_doc: 'v1/swagger.json' do
  let(:user) { create(:user) }
  let(:user_email) { user.email }
  let(:user_token) { user.authentication_token }

  let(:recipe) { create(:recipe, user: user) }
  let(:ingredient) { create(:ingredient, user: user) }
  let(:recipe_id) { recipe.id }

  path '/recipes/{recipe_id}/recipe_ingredients' do
    parameter name: :recipe_id, in: :path, type: :integer
    parameter name: :user_email, in: :query, type: :string
    parameter name: :user_token, in: :query, type: :string

    post 'Creates Recipe Ingredient' do
      description 'Creates Recipe Ingredient'
      consumes 'application/json'
      produces 'application/json'
      parameter(
        name: :recipe_ingredient,
        in: :body,
        schema: {
          type: "object",
          properties: {
            recipe_ingredient: { "$ref" => "#/definitions/recipe_ingredient" }
          },
          required: [
            :recipe_ingredient
          ]
        }
      )

      response '201', 'recipe_ingredient created' do
        let(:recipe_ingredient) do
          {
            ingredient_id: ingredient.id,
            ingredient_quantity: 3
          }
        end

        run_test!
      end

      response '401', 'user unauthorized' do
        let(:recipe_ingredient) { {} }
        let(:user_token) { 'invalid' }

        run_test!
      end
    end
  end

  path '/recipes/{recipe_id}/recipe_ingredients/{id}' do
    parameter name: :recipe_id, in: :path, type: :integer
    parameter name: :user_email, in: :query, type: :string
    parameter name: :user_token, in: :query, type: :string

    parameter name: :id, in: :path, type: :integer

    let(:existent_recipe_ingredient) do
      create(:recipe_ingredient, recipe: recipe, ingredient: ingredient)
    end
    let(:id) { existent_recipe_ingredient.id }

    put 'Updates Recipe Ingredient' do
      description 'Updates Recipe Ingredient'
      consumes 'application/json'
      produces 'application/json'
      parameter(
        name: :recipe_ingredient,
        in: :body,
        schema: {
          type: "object",
          properties: {
            recipe_ingredient: { "$ref" => "#/definitions/recipe_ingredient" }
          },
          required: [
            :recipe_ingredient
          ]
        }
      )

      response '200', 'recipe_ingredient updated' do
        let(:recipe_ingredient) do
          {
            ingredient_id: ingredient.id,
            ingredient_quantity: 4
          }
        end

        run_test!
      end

      response '401', 'user unauthorized' do
        let(:recipe_ingredient) { {} }
        let(:user_token) { 'invalid' }

        run_test!
      end
    end

    delete 'Deletes Recipe Ingredient' do
      produces 'application/json'
      description 'Deletes specific recipe_ingredient'

      response '204', 'recipe_ingredient deleted' do
        run_test!
      end

      response '404', 'recipe_ingredient not found' do
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
