require 'swagger_helper'

describe 'API::V1::Ingredients', swagger_doc: 'v1/swagger.json' do
  let(:user) { create(:user) }
  let(:user_email) { user.email }
  let(:user_token) { user.authentication_token }

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
      allow_any_instance_of(JumboClient).to receive(:products_by_query).with(
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

        run_test!
      end

      response "401", "with invalid user token" do
        let(:user_token) { "invalid" }

        run_test!
      end
    end
  end
end
