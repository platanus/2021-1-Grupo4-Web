require 'rails_helper'

RSpec.describe CornershopClient do
  let(:query) { 'pan' }
  let(:user) { create(:user) }
  let(:mocked_response) do
    {
      "results":
      [
        {
          "store": {
            "id": 4,
            "name": "Jumbo"
          },
          "search_result":
            {
              "search_term": "pan",
              "aisles": [
                {
                  "aisle_id": "C_572",
                  "products":
                  [
                    {
                      "id": 376521,
                      "brand": { "id": 1893, "name": "Kingsbury" },
                      "kind": "PRODUCT",
                      "related_to": nil,
                      "buy_unit": "UN",
                      "default_buy_unit": "UN",
                      "purchasable": true,
                      "price": 1950.0,
                      "original_price": nil,
                      "name": "Pan molde perfecto blanco",
                      "package": "Bolsa 600 g",
                      "img_url": "https://s.cornershopapp.com/img-url"
                    },
                    {
                      "id": 376522,
                      "brand": { "id": 1894, "name": "Ideal" },
                      "kind": "PRODUCT",
                      "related_to": nil,
                      "buy_unit": "UN",
                      "default_buy_unit": "UN",
                      "purchasable": true,
                      "price": 1950.0,
                      "original_price": 2250.0,
                      "name": "Pan molde XL",
                      "package": "Bolsa 10 rebanadas",
                      "img_url": "https://s.cornershopapp.com/img-url-2"
                    }
                  ]
                }
              ]
            }
        }
      ]
    }
  end

  let(:expected_response) do
    [
      {
        provider: hash_including(name: 'Jumbo'),
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

  before do
    allow(HTTParty).to receive(:get).and_return(mocked_response.deep_stringify_keys)
  end

  def call_products_by_query
    described_class.new.products_by_query(query: query)
  end

  describe 'products by query response' do
    let(:correct_url) do
      'https://cornershopapp.com/api/v2/branches/search?query=pan&country=CL&locality=Providencia'
    end

    it 'calls GET to the correct url' do
      call_products_by_query

      expect(HTTParty).to have_received(:get).with(correct_url)
    end

    it 'returns correct response' do
      expect(call_products_by_query).to match(expected_response)
    end
  end
end
