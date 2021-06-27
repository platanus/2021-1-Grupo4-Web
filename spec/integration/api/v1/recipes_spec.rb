require 'swagger_helper'

# rubocop:disable RSpec/EmptyExampleGroup, RSpec/MultipleMemoizedHelpers
describe 'Api::V1::Recipes', swagger_doc: 'v1/swagger.json' do
  let!(:user) { create(:user) }
  let(:user_email) { user.email }
  let(:user_token) { user.authentication_token }
  let(:user_id) { user.id }
  let(:new_recipe) { create(:recipe, user_id: user.id) }

  path '/recipes' do
    parameter name: :user_email, in: :query, type: :string
    parameter name: :user_token, in: :query, type: :string

    get 'Retrieves Recipes' do
      description 'Retrieves all the recipes'
      produces 'application/json'

      let(:collection_count) { 5 }
      before do
        collection_count.times do |_time|
          create(:recipe, user_id: user.id)
        end
      end

      response '200', 'Recipes retrieved' do
        schema('$ref' => '#/definitions/recipes_collection')

        run_test! do |response|
          expect(JSON.parse(response.body)['data'].count).to eq(collection_count)
        end
      end

      response '401', 'user unauthorized' do
        let(:user_token) { 'invalid' }

        run_test!
      end
    end

    post 'Creates Recipe' do
      description 'Creates Recipe'
      consumes 'application/json'
      produces 'application/json'
      parameter(name: :recipe, in: :body,
                schema: {
                  type: "object",
                  properties: {
                    recipe: { "$ref" => "#/definitions/recipe" }
                  },
                  required: [
                    :recipe
                  ]
                })

      response '201', 'recipe created' do
        let(:recipe) do
          {
            user_id: new_recipe.id,
            name: new_recipe.name,
            portions: new_recipe.portions,
            cook_minutes: new_recipe.cook_minutes
          }
        end

        run_test!
      end

      response '401', 'user unauthorized' do
        let(:recipe) { {} }
        let(:user_token) { 'invalid' }

        run_test!
      end
    end
  end

  path '/recipes/{id}' do
    parameter name: :user_email, in: :query, type: :string
    parameter name: :user_token, in: :query, type: :string

    parameter name: :id, in: :path, type: :integer

    let(:existent_recipe) { create(:recipe, user_id: user.id) }
    let(:id) { existent_recipe.id }

    get 'Retrieves Recipe' do
      produces 'application/json'

      response '200', 'recipe retrieved' do
        schema('$ref' => '#/definitions/recipe_resource')

        run_test!
      end

      response '404', 'invalid recipe id' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '401', 'user unauthorized' do
        let(:user_token) { 'invalid' }

        run_test!
      end
    end

    put 'Updates Recipe' do
      description 'Updates Recipe'
      consumes 'application/json'
      produces 'application/json'
      parameter(name: :recipe, in: :body,
                schema: {
                  type: "object",
                  properties: {
                    recipe: { "$ref" => "#/definitions/recipe_update" }
                  },
                  required: [
                    :recipe
                  ]
                })

      response '200', 'recipe updated' do
        let(:recipe) do
          {
            user_id: user.id,
            name: 'Some name',
            portions: 666,
            cook_minutes: 666
          }
        end

        run_test!
      end

      response '401', 'user unauthorized' do
        let(:recipe) { {} }
        let(:user_token) { 'invalid' }

        run_test!
      end
    end

    delete 'Deletes Recipe' do
      produces 'application/json'
      description 'Deletes specific recipe'

      response '204', 'recipe deleted' do
        run_test!
      end

      response '404', 'recipe not found' do
        let(:id) { 'invalid' }

        run_test!
      end

      response '401', 'user unauthorized' do
        let(:user_token) { 'invalid' }

        run_test!
      end
    end
  end

  path '/recipes/{id}/critical-associations' do
    parameter name: :user_email, in: :query, type: :string
    parameter name: :user_token, in: :query, type: :string

    parameter name: :id, in: :path, type: :integer

    let!(:existent_recipe) { create(:recipe, user_id: user.id) }
    let!(:existent_menu) { create(:menu, user_id: user.id) }
    let!(:menu_recipe) do
      create(:menu_recipe, recipe: existent_recipe, menu: existent_menu)
    end
    let(:id) { existent_recipe.id }

    get 'Retrieves recipe critical associations for confirming delete' do
      produces 'application/json'

      let(:expected_response) do
        {
          menus: [hash_including(name: existent_menu.name)]
        }
      end

      response '200', 'recipe associations retrieved' do
        schema('$ref' => '#/definitions/recipe_critical_associations')

        run_test! do |response|
          body = JSON.parse(response.body)
          expect(body.deep_symbolize_keys).to match(expected_response)
        end
      end

      response '404', 'invalid recipe id' do
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
