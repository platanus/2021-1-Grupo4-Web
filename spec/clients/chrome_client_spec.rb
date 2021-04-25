require 'rails_helper'

RSpec.describe ChromeClient do
  let(:client) { described_class.new }
  let(:default_timeout) { 15 }
  let(:browser) { instance_double('Chrome Browser', close: true) }
  let(:chrome_driver) { instance_double('ChromeDriver') }

  before do
    allow(Selenium::WebDriver).to receive(:for).and_return(chrome_driver)
    allow(Selenium::WebDriver::Chrome::Service).to receive(:driver_path=).and_return(true)
    allow(Pincers).to receive(:for_webdriver).and_return(browser)
  end

  let(:chrome_options) { Selenium::WebDriver::Chrome::Options.new }
  let(:chrome_driver) { instance_double('ChromeDriver') }

  before do
    allow(Selenium::WebDriver).to receive(:for).and_return(chrome_driver)
  end

  describe 'create chrome browser' do
    it 'creates when calling browser method' do
      client.browser

      expect(Pincers).to have_received(:for_webdriver).with(
        chrome_driver, wait_timeout: default_timeout
      )
    end
  end

  describe 'ensuring browser closure' do
    it 'ensures to close browser before exiting' do
      client.ensuring_browser_closure do
        client.browser
      end

      expect(browser).to have_received(:close)
    end
  end
end
