require 'swagger_helper'

describe 'API::V1::Recipes', swagger_doc: 'v1/swagger.json' do
  let(:user) { create(:user) }
  let(:user_email) { user.email }
  let(:user_token) { user.authentication_token }

  path '/recipes' do
    parameter name: :user_email, in: :query, type: :string
    parameter name: :user_token, in: :query, type: :string

    get 'Retrieves Recipes' do
      description 'Retrieves all the recipes'
      produces 'application/json'

      let(:collection_count) { 5 }
      let(:expected_collection_count) { collection_count }

      before { create_list(:recipe, collection_count) }

      response '200', 'Recipes retrieved' do
        schema('$ref' => '#/definitions/recipes_collection')

        run_test! do |response|
          expect(JSON.parse(response.body)['data'].count).to eq(expected_collection_count)
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
      parameter(name: :recipe, in: :body)

      response '201', 'recipe created' do
        let(:recipe) do
          {
            user_id: 666,
            name: 'Some name',
            portions: 666,
            instructions: 'Some instructions',
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
  end

  path '/recipes/{id}' do
    parameter name: :user_email, in: :query, type: :string
    parameter name: :user_token, in: :query, type: :string

    parameter name: :id, in: :path, type: :integer

    let(:existent_recipe) { create(:recipe) }
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
      parameter(name: :recipe, in: :body)

      response '200', 'recipe updated' do
        let(:recipe) do
          {
            user_id: 666,
            name: 'Some name',
            portions: 666,
            instructions: 'Some instructions',
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
end
