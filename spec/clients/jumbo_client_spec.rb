require 'rails_helper'

# rubocop:disable RSpec/MultipleMemoizedHelpers
RSpec.describe JumboClient do
  let(:query) { 'pan' }
  let(:client_instance) { described_class.new }
  let(:user) { create(:user) }

  let(:measure_result) { instance_double('Measure div', text: '1 Un.') }
  let(:name_result) { [instance_double('Title div', text: 'Pan del oso.'), double] }
  let(:url_result) { [instance_double('Image div', attribute: 'some-url.com')] }
  let(:image_result) { instance_double('Image', wait: url_result) }
  let(:expected_package) { '1 Un.' }
  let(:expected_measure) { 'Un.' }
  let(:expected_quantity) { 1 }
  let(:expected_name) { 'Pan del oso.' }
  let(:expected_image_url) { 'some-url.com' }

  let(:browser) { instance_double('Chrome Browser', close: true, goto: true) }

  let(:products_search) { instance_double('Products search') }
  let(:product) { instance_double('Product') }
  let(:products) { [product] }

  let!(:provider) { create(:provider, name: 'Jumbo', user: user) }

  def call_products_by_query
    described_class.new.products_by_query(query: query)
  end

  def mock_products_found
    allow(browser).to receive(:search).with('.shelf-item').and_return(products_search)
    allow(products_search).to receive(:wait).with(:present, timeout: 10.0).and_return(products)
  end

  def mock_product
    allow(product).to receive(:search).with('.shelf-single-unit').and_return(measure_result)
    allow(product).to receive(:search).with('.shelf-product-title h2').and_return(name_result)
    allow(product).to receive(:search).with('.lazy-image').and_return(image_result)
  end

  def mock_product_prices
    allow(product).to receive(:search).with('.product-single-price-container').and_return(
      price_result
    )
    allow(product).to receive(:search).with('.price-product-value').and_return(old_price_result)
    allow(product).to receive(:search).with('.price-product-best').and_return(offer_price_result)
  end

  before do
    allow(described_class).to receive(:new).and_return(client_instance)
    allow(client_instance).to receive(:browser).and_return(browser)

    mock_products_found
  end

  describe 'get all products with normal price even with promotion' do
    let(:price_result) { instance_double('Price div', text: "$ 12 390\n($12 390/kg)") }
    let(:old_price_result) { instance_double('Old price div', text: "$ 13 390") }
    let(:offer_price_result) { [instance_double('Offer price div', text: "$ 8 390"), double] }

    let(:expected_price) { 12390 }

    let(:expected_result) do
      [{
        provider: { name: 'Jumbo' },
        products: [
          {
            price: expected_price,
            package: expected_package,
            quantity: expected_quantity,
            measure: expected_measure,
            name: expected_name,
            img_url: expected_image_url
          }
        ]
      }]
    end

    before do
      mock_product
      mock_product_prices
    end

    it 'returns an array of hashes with information including normal price' do
      expect(call_products_by_query).to eq(expected_result)
    end
  end

  describe 'get all products when there is promotion and old price is found' do
    let(:price_result) { instance_double('Price div', text: "") }
    let(:old_price_result) { instance_double('Old price div', text: "$ 13 390") }
    let(:offer_price_result) { [instance_double('Offer price div', text: "$ 8 390"), double] }

    let(:expected_price) { 13390 }

    let(:expected_result) do
      [{
        provider: { name: 'Jumbo' },
        products: [
          {
            price: expected_price,
            package: expected_package,
            quantity: expected_quantity,
            measure: expected_measure,
            name: expected_name,
            img_url: expected_image_url
          }
        ]
      }]
    end

    before do
      mock_product
      mock_product_prices
    end

    it 'returns an array of hashes with information including old price' do
      expect(call_products_by_query).to eq(expected_result)
    end
  end

  describe 'get all products when there is promotion and old price isnt found' do
    let(:price_result) { instance_double('Price div', text: "") }
    let(:old_price_result) { instance_double('Old price div', text: "") }
    let(:offer_price_result) { [instance_double('Offer price div', text: "$ 8 390"), double] }

    let(:expected_price) { 8390 }

    let(:expected_result) do
      [{
        provider: { name: 'Jumbo' },
        products: [
          {
            price: expected_price,
            package: expected_package,
            quantity: expected_quantity,
            measure: expected_measure,
            name: expected_name,
            img_url: expected_image_url
          }
        ]
      }]
    end

    before do
      mock_product
      mock_product_prices
    end

    it 'returns an array of hashes with information including offer price' do
      expect(call_products_by_query).to eq(expected_result)
    end
  end

  describe 'cant get products because of timeout' do
    let(:expected_result) { [] }

    before do
      allow(browser).to receive(:search).with('.shelf-item').and_return(products_search)
      allow(products_search).to receive(:wait).with(:present, timeout: 10.0).and_raise(
        Pincers::ConditionTimeoutError.new(anything, 'Timed out waiting element to be present')
      )
    end

    it 'returns an empty array' do
      expect(call_products_by_query).to eq(expected_result)
    end
  end
end
# rubocop:enable RSpec/MultipleMemoizedHelpers
