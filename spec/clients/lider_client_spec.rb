require 'rails_helper'

# rubocop:disable RSpec/MultipleMemoizedHelpers
RSpec.describe LiderClient do
  let(:query) { 'carne' }
  let(:lider_client) { described_class.new }
  let(:user) { create(:user) }

  let(:price) { instance_double('Price div', text: '$1.990') }
  let(:package) { instance_double('Package div', text: '500 g') }
  let(:name) { instance_double('Name div', text: 'Carne Molida 4%') }

  let(:image_response) { instance_double('Image tag', value: 'some-url.com') }
  let(:image_url) { instance_double('URL div', attr: image_response) }

  let(:document) { instance_double('Document') }

  let(:product) { instance_double('Product') }
  let(:products) { [product] }

  def call_products_by_query
    lider_client.products_by_query(query: query)
  end

  def mock_products_found
    allow(document).to receive(:css).with("div[id^=\"productBox\"]").and_return(products)
  end

  def mock_product
    allow(product).to receive(:css).with('/div[2]/div[1]/div/span[1]').and_return(package)
    allow(product).to receive(:css).with('/div[2]/div[1]/a/span[2]').and_return(name)
    allow(product).to receive(:css).with('/div[1]/div[1]/a/div/img').and_return(image_url)
  end

  def mock_product_prices
    allow(product).to receive(:css).with('/div[2]/div[1]/div/span[2]/b').and_return(price)
  end

  before do
    allow(described_class).to receive(:new).and_return(lider_client)
    allow(Nokogiri::HTML::Document).to receive(:parse).and_return(document)
    mock_products_found
  end

  describe 'getting all products' do
    let!(:provider) { create(:provider, name: 'Lider', user: user) }

    let(:expected_result) do
      [
        {
          provider: { name: 'Lider' },
          products: [
            {
              price: 1990,
              measure: 'g',
              quantity: 500,
              package: '500 g',
              name: 'Carne Molida 4%',
              img_url: 'some-url.com'
            }
          ]
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
# rubocop:enable RSpec/MultipleMemoizedHelpers
