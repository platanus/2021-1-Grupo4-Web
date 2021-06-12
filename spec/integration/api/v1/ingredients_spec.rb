require 'swagger_helper'

# rubocop:disable RSpec/EmptyExampleGroup, RSpec/MultipleMemoizedHelpers, RSpec/ScatteredSetup
describe 'API::V1::Ingredients', swagger_doc: 'v1/swagger.json' do
  let!(:user) { create(:user) }
  let(:user_email) { user.email }
  let(:user_token) { user.authentication_token }
  let(:user_id) { user.id }
  let(:query) { 'pan' }

  let(:products) do
    [
      { price: "$ 1.150", measure: "500 g", name: "Pan coliza peruana", provider: provider },
      { price: "$ 770", measure: "500 g", name: "Pan hallulla delgada", provider: provider },
      { price: "$ 770", measure: "500 g", name: "Pan hallulla", provider: provider },
      { price: "$ 920", measure: "500 g", name: "Pan de hot dog", provider: provider },
      { price: "$ 995", measure: "500 g", name: "Pan doblada", provider: provider }
    ]
  end

  path '/search-jumbo-products' do
    let(:jumbo_client) { instance_double('JumboClient', products_by_query: products) }
    let(:provider) { 'Jumbo' }

    parameter name: :user_email, in: :query, type: :string
    parameter name: :user_token, in: :query, type: :string
    parameter name: :query, in: :query, type: :string

    before do
      allow(JumboClient).to receive(:new).and_return(jumbo_client)
    end

    get 'Search ingredients on Jumbo web' do
      consumes 'application/json'
      produces 'application/json'
      description 'Retrieves ingredients from Jumbo'

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

        run_test!
      end

      response '401', 'user unauthorized' do
        let(:user_token) { 'invalid' }

        run_test!
      end
    end
  end

  path '/search-lider-products' do
    let(:lider_client) { instance_double('LiderClient', products_by_query: products) }
    let(:provider) { 'Lider' }

    parameter name: :user_email, in: :query, type: :string
    parameter name: :user_token, in: :query, type: :string
    parameter name: :query, in: :query, type: :string

    before do
      allow(LiderClient).to receive(:new).and_return(lider_client)
    end

    get 'Search ingredients on Lider web' do
      consumes 'application/json'
      produces 'application/json'
      description 'Retrieves ingredients from Lider'

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

        run_test!
      end

      response '401', 'user unauthorized' do
        let(:user_token) { 'invalid' }

        run_test!
      end
    end
  end

  path '/search-cornershop-products' do
    let(:cornershop_client) do
      instance_double('CornershopClient', products_by_query: products)
    end
    let!(:provider) { create(:provider, name: 'Jumbo', user: user) }

    parameter name: :user_email, in: :query, type: :string
    parameter name: :user_token, in: :query, type: :string
    parameter name: :query, in: :query, type: :string

    before do
      allow(CornershopClient).to receive(:new).and_return(cornershop_client)
    end

    let(:products) do
      [
        {
          provider: provider.as_json,
          products:
            [
              {
                price: 1950.0,
                measure: "UN",
                package: "Bolsa 600 g",
                name: "Kingsbury - Pan molde perfecto blanco",
                img_url: "https://s.cornershopapp.com/img-url"
              },
              {
                price: 2250.0,
                measure: "UN",
                package: "Bolsa 10 rebanadas",
                name: "Ideal - Pan molde XL",
                img_url: "https://s.cornershopapp.com/img-url-2"
              }
            ]
        }
      ]
    end

    get 'Search products on Cornershop' do
      consumes 'application/json'
      produces 'application/json'
      description 'Retrieves products from different markets'

      response '200', 'products retrieved' do
        schema(
          type: "object",
          properties: {
            data: {
              type: "array",
              items: { "$ref" => "#/definitions/cornershop_product" }
            }
          }
        )

        run_test!
      end

      response '401', 'user unauthorized' do
        let(:user_token) { 'invalid' }

        run_test!
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
            inventory: 25,
            ingredient_measures_attributes: [
              {
                name: 'Kg',
                quantity: 1
              }
            ]
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
            inventory: 15
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
# rubocop:enable RSpec/EmptyExampleGroup, RSpec/MultipleMemoizedHelpers, RSpec/ScatteredSetup
