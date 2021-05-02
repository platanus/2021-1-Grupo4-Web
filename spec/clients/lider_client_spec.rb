require 'rails_helper'

RSpec.describe LiderClient do
  let(:query) { 'carne' }

  let(:brand_result) { instance_double('Brand div', text: 'El Buen Corte') }
  let(:measure_result) { instance_double('Measure div', text: '500 g') }
  let(:name_result) { instance_double('Description div', text: 'Carne Molida 4%') }
  let(:expected_brand) { 'El Buen Corte' }
  let(:expected_measure) { '500 g' }
  let(:expected_name) { 'Carne Molida 4%' }

  let(:browser) { instance_double('Chrome Browser', close: true, goto: true) }

  let(:products_search) { instance_double('Products search') }
  let(:product) { instance_double('Product') }
  let(:products) { [product] }

  def call_products_by_query
    described_class.new.products_by_query(query: query)
  end

  def mock_products_found
    allow(browser).to receive(:search).with('.product-details').and_return(products_search)
    allow(products_search).to receive(:wait).with(:present, timeout: 5.0).and_return(products)
  end

  def mock_product
    allow(product).to receive(:search).with('.product-attribute').and_return(measure_result)
    allow(product).to receive(:search).with('.product-description').and_return(name_result)
    allow(product).to receive(:search).with('.product-name').and_return(brand_result)
  end

  def mock_product_prices
    allow(product).to receive(:search).with('.price-internet').and_return(normal_price_result)
    allow(product).to receive(:search).with('.price-sell').and_return(offer_price_result)
  end

  before do
    allow_any_instance_of(described_class).to receive(:browser).and_return(browser)
    mock_products_found
  end

  describe 'getting all products with normal and offer price' do
    let(:offer_price_result) { instance_double('Offer price div', text: "$4.690") }
    let(:normal_price_result) { instance_double('Normal price div', text: nil) }

    let(:expected_offer_price) { '$4.690' }
    let(:expected_normal_price) { nil }

    let(:expected_result) do
      [
        {
          brand: expected_brand,
          offer_price: expected_offer_price,
          normal_price: expected_normal_price,
          measure: expected_measure,
          name: expected_name
        }
      ]
    end

    before do
      mock_product
      mock_product_prices
    end

    it 'returns a product with all its information' do
      expect(call_products_by_query).to eq(expected_result)
    end
  end
end