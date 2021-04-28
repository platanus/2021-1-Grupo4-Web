require 'selenium-webdriver'

class ChromeClient
  CHROME_CLIENT_TIMEOUT = 15

  def browser
    @browser ||= Pincers.for_webdriver(
      driver,
      wait_timeout: CHROME_CLIENT_TIMEOUT
    )
  end

  def ensuring_browser_closure(&block)
    block.call
  ensure
    browser&.close
    @browser = nil
  end

  private

  def driver
    chrome_path = ENV.fetch('GOOGLE_CHROME_BIN_PATH')
    set_chromedriver_path

    Selenium::WebDriver.for(:chrome, options: chrome_options(chrome_path))
  end

  def set_chromedriver_path
    chromedriver_path = ENV.fetch('GOOGLE_CHROMEDRIVER_BIN_PATH')

    Selenium::WebDriver::Chrome::Service.driver_path = chromedriver_path
  end

  def chrome_options(chrome_path)
    chrome_options = Selenium::WebDriver::Chrome::Options.new
    chrome_options.add_argument("--headless")
    chrome_options.binary = chrome_path

    chrome_options
  end
end
