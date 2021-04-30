require 'rails_helper'

RSpec.describe ChromeClient do
  let(:client) { described_class.new }
  let(:default_timeout) { 15 }
  let(:driver) { instance_double('ChromeDriver') }

  describe 'create chrome browser' do
    before do
      allow(Pincers).to receive(:for_webdriver).and_return(driver)
    end

    it 'creates when calling browser method' do
      client.browser

      expect(Pincers).to have_received(:for_webdriver).with(:chrome, wait_timeout: default_timeout)
    end
  end

  describe 'ensuring browser closure' do
    let(:browser) { instance_double('Chrome Browser', close: true) }

    before do
      allow(Pincers).to receive(:for_webdriver).and_return(browser)
      allow(browser).to receive(:close).and_return(true)
    end

    it 'ensures to close browser before exiting' do
      client.ensuring_browser_closure do
        client.browser
      end

      expect(browser).to have_received(:close)
    end
  end
end
