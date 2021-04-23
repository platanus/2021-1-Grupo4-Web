require 'rails_helper'

RSpec.describe ChromeClient do
  let(:client) { described_class.new }
  let(:default_timeout) { 15 }

  describe 'create chrome browser' do
    it 'creates when calling browser method' do
      expect(Pincers).to receive(:for_webdriver).with(:chrome, wait_timeout: default_timeout)

      client.browser
    end
  end

  describe 'ensuring browser closure' do
    let(:browser) { instance_double('Chrome Browser', close: true) }

    before do
      allow(Pincers).to receive(:for_webdriver).and_return(browser)
    end

    it 'ensures to close browser before exiting' do
      expect(browser).to receive(:close)

      client.ensuring_browser_closure do
        client.browser
      end
    end
  end
end
