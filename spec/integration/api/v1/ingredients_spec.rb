require 'swagger_helper'

describe 'API::V1::Ingredients', swagger_doc: 'v1/swagger.json' do
  let!(:user) { create(:user) }
  let(:user_email) { user.email }
  let(:user_token) { user.authentication_token }
  let(:user_id) { user.id }
  let(:jumbo_client) { JumboClient.new }

  path '/search-ingredients' do
    parameter name: :user_email, in: :query, type: :string
    parameter name: :user_token, in: :query, type: :string
    parameter name: :query, in: :query, type: :string

    let(:products) do
      [
        { price: "$ 1.150", measure: "500 g", name: "Pan coliza peruana", provider: "Jumbo" },
        { price: "$ 770", measure: "500 g", name: "Pan hallulla delgada", provider: "Jumbo" },
        { price: "$ 770", measure: "500 g", name: "Pan hallulla", provider: "Jumbo" },
        { price: "$ 920", measure: "500 g", name: "Pan de hot dog", provider: "Jumbo" },
        { price: "$ 995", measure: "500 g", name: "Pan doblada", provider: "Jumbo" }
      ]
    end
    let(:query) { 'pan' }

    before do
      allow(JumboClient).to receive(:new).and_return(jumbo_client)
      allow(jumbo_client).to receive(:products_by_query).with(
        query: 'pan'
      ).and_return(products)
    end

    get 'Search ingredients' do
      consumes 'application/json'
      produces 'application/json'
      description 'Retrieves ingredients by different providers'

      response '200', 'ingredients retrieved' do
        schema(
          type: "object",
          properties: {
            data: {
              type: "array",
              items: { "$ref" => "#/definitions/provider_ingredient" }
            }
          },
          required: [
            :data
          ]
        )
      end
    end
  end

  path '/ingredients' do
    parameter name: :user_email, in: :query, type: :string
    parameter name: :user_token, in: :query, type: :string

    get 'Retrieves Ingredients' do
      description 'Retrieves all the ingredients'
      produces 'application/json'

      let(:collection_count) { 5 }
      before do
        collection_count.times do |_time|
          create(:ingredient, user_id: user.id)
        end
      end

      response '200', 'Ingredients retrieved' do
        schema('$ref' => '#/definitions/ingredients_collection')

        run_test! do |response|
          expect(JSON.parse(response.body)['data'].count).to eq(collection_count)
        end
      end

      response '401', 'user unauthorized' do
        let(:user_token) { 'invalid' }

        run_test!
      end
    end

    post 'Creates Ingredient' do
      description 'Creates Ingredient'
      consumes 'application/json'
      produces 'application/json'
      parameter(
        name: :ingredient,
        in: :body,
        schema: {
          type: "object",
          properties: {
            ingredient: { "$ref" => "#/definitions/ingredient" }
          },
          required: [
            :ingredient
          ]
        }
      )

      response '201', 'ingredient created' do
        let(:ingredient) do
          {
            user_id: user.id,
            name: 'Some name',
            sku: 'Some sku',
            price: 666,
            currency: 'Some currency',
            quantity: 666,
            measure: 'Some measure'
          }
        end

        run_test!
      end

      response '401', 'user unauthorized' do
        let(:ingredient) { {} }
        let(:user_token) { 'invalid' }

        run_test!
      end
    end
  end

  path '/ingredients/{id}' do
    parameter name: :user_email, in: :query, type: :string
    parameter name: :user_token, in: :query, type: :string

    parameter name: :id, in: :path, type: :integer

    let(:existent_ingredient) { create(:ingredient, user_id: user.id) }
    let(:id) { existent_ingredient.id }

    get 'Retrieves Ingredient' do
      produces 'application/json'

      response '200', 'ingredient retrieved' do
        schema('$ref' => '#/definitions/ingredient_resource')

        run_test!
      end

      response '404', 'invalid ingredient id' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '401', 'user unauthorized' do
        let(:user_token) { 'invalid' }

        run_test!
      end
    end

    put 'Updates Ingredient' do
      description 'Updates Ingredient'
      consumes 'application/json'
      produces 'application/json'
      parameter(
        name: :ingredient,
        in: :body,
        schema: {
          type: "object",
          properties: {
            ingredient: { "$ref" => "#/definitions/ingredient" }
          },
          required: [
            :ingredient
          ]
        }
      )

      response '200', 'ingredient updated' do
        let(:ingredient) do
          {
            user_id: user.id,
            name: 'Some name',
            sku: 'Some sku',
            price: 666,
            currency: 'Some currency',
            quantity: 666,
            measure: 'Some measure'
          }
        end

        run_test!
      end

      response '401', 'user unauthorized' do
        let(:ingredient) { {} }
        let(:user_token) { 'invalid' }

        run_test!
      end
    end

    delete 'Deletes Ingredient' do
      produces 'application/json'
      description 'Deletes specific ingredient'

      response '204', 'ingredient deleted' do
        run_test!
      end

      response '404', 'ingredient not found' do
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
