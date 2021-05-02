require 'rails_helper'

RSpec.describe MarketClient do
  let(:market_client) { described_class.new }
  let(:query) { 'pan' }
  let(:browser) { instance_double('ChromeBrowser', goto: true, close: true) }

  before do
    allow(described_class).to receive(:new).and_return(market_client)
    allow(market_client).to receive(:browser).and_return(browser)
  end

  describe 'products_page not implemented' do
    it 'raise not implemented error' do
      expect { market_client.products_by_query(query: query) }.to raise_error(NotImplementedError)
    end
  end
end
