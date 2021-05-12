require 'swagger_helper'

describe 'API::V1::Recipes', swagger_doc: 'v1/swagger.json' do
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
            instructions: new_recipe.instructions,
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
                    recipe: { "$ref" => "#/definitions/recipe" }
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

  path '/recipes/{id}/add_ingredient' do
    parameter name: :user_email, in: :query, type: :string
    parameter name: :user_token, in: :query, type: :string

    parameter name: :id, in: :path, type: :integer

    let!(:existent_recipe) { create(:recipe, user_id: user.id) }
    let!(:existent_ingredient) { create(:ingredient, user_id: user.id) }
    let(:id) { existent_recipe.id }
    let(:ingredient_id) { existent_ingredient.id }

    post 'Add ingredient to recipe' do
      description 'Add existing ingredient to specific recipe'
      consumes 'application/json'
      produces 'application/json'
      parameter(name: :recipe_ingredient, in: :body,
                schema: {
                  type: "object",
                  properties: {
                    recipe_ingredient: { "$ref" => "#/definitions/recipe_ingredient" }
                  },
                  required: [
                    :recipe_ingredient
                  ]
                })

      let(:recipe_ingredient) do
        {
          ingredient_id: ingredient_id,
          ingredient_quantity: 3
        }
      end

      response '200', 'recipe ingredient added' do
        run_test!
      end

      response '401', 'user unauthorized' do
        let(:user_token) { 'invalid' }

        run_test!
      end
    end
  end

  path '/recipes/{id}/remove_ingredient' do
    parameter name: :user_email, in: :query, type: :string
    parameter name: :user_token, in: :query, type: :string

    parameter name: :id, in: :path, type: :integer

    let!(:existent_recipe) { create(:recipe, user_id: user.id) }
    let!(:existent_ingredient) { create(:ingredient, user_id: user.id) }
    let(:id) { existent_recipe.id }
    let(:ingredient_id) { existent_ingredient.id }

    before do
      create(:recipe_ingredient, recipe: existent_recipe, ingredient: existent_ingredient)
    end

    post 'Remove ingredient of recipe' do
      description 'Remove existing ingredient of specific recipe'
      consumes 'application/json'
      produces 'application/json'
      parameter(name: :recipe_ingredient, in: :body,
                schema: {
                  type: "object",
                  properties: {
                    recipe_ingredient: { "$ref" => "#/definitions/recipe_ingredient" }
                  },
                  required: [
                    :recipe_ingredient
                  ]
                })

      let(:recipe_ingredient) do
        {
          ingredient_id: ingredient_id,
          ingredient_quantity: 3
        }
      end

      response '201', 'recipe ingredient removed' do
        run_test!
      end

      response '401', 'user unauthorized' do
        let(:user_token) { 'invalid' }

        run_test!
      end
    end
  end
end
