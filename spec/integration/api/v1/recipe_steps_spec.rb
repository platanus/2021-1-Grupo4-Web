require 'swagger_helper'

# rubocop:disable RSpec/EmptyExampleGroup, RSpec/MultipleMemoizedHelpers
describe 'Api::V1::RecipeSteps', swagger_doc: 'v1/swagger.json' do
  let(:user) { create(:user) }
  let(:user_email) { user.email }
  let(:user_token) { user.authentication_token }

  let!(:recipe) { create(:recipe, user: user) }
  let(:recipe_id) { recipe.id }

  path '/recipes/{recipe_id}/recipe_steps' do
    parameter name: :recipe_id, in: :path, type: :integer
    parameter name: :user_email, in: :query, type: :string
    parameter name: :user_token, in: :query, type: :string

    post 'Creates Recipe Step' do
      description 'Creates Recipe Step'
      consumes 'application/json'
      produces 'application/json'
      parameter(
        name: :recipe_step,
        in: :body,
        schema: {
          type: "object",
          properties: {
            recipe_step: { "$ref" => "#/definitions/recipe_step" }
          },
          required: [
            :recipe_step
          ]
        }
      )

      response '201', 'recipe_step created' do
        let(:recipe_step) do
          {
            description: 'Some description'
          }
        end

        run_test!
      end

      response '401', 'user unauthorized' do
        let(:recipe_step) { {} }
        let(:user_token) { 'invalid' }

        run_test!
      end
    end
  end

  path '/recipes/{recipe_id}/recipe_steps/{id}' do
    parameter name: :recipe_id, in: :path, type: :integer
    parameter name: :user_email, in: :query, type: :string
    parameter name: :user_token, in: :query, type: :string

    parameter name: :id, in: :path, type: :integer

    let(:existent_recipe_step) { create(:recipe_step, recipe: recipe) }
    let(:id) { existent_recipe_step.id }

    put 'Updates Recipe Step' do
      description 'Updates Recipe Step'
      consumes 'application/json'
      produces 'application/json'
      parameter(
        name: :recipe_step,
        in: :body,
        schema: {
          type: "object",
          properties: {
            recipe_step: { "$ref" => "#/definitions/recipe_step_update" }
          },
          required: [
            :recipe_step
          ]
        }
      )

      response '200', 'recipe_step updated' do
        let(:recipe_step) do
          {
            step_order_position: 1,
            description: 'Some description'
          }
        end

        run_test!
      end

      response '401', 'user unauthorized' do
        let(:recipe_step) { {} }
        let(:user_token) { 'invalid' }

        run_test!
      end
    end

    delete 'Deletes Recipe Step' do
      produces 'application/json'
      description 'Deletes specific recipe_step'

      response '204', 'recipe_step deleted' do
        run_test!
      end

      response '404', 'recipe_step not found' do
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
