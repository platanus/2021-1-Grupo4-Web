require 'selenium-webdriver'

class ChromeClient
<<<<<<< HEAD
  CHROME_CLIENT_TIMEOUT = 15

  def browser
    @browser ||= Pincers.for_webdriver(
      driver,
      wait_timeout: CHROME_CLIENT_TIMEOUT
    )
=======
  CHROME_CLIENT_TIMEOUT = 35
  ENABLE_HEADLESS_CHROME = true

  @@options = Selenium::WebDriver::Chrome::Options.new

  def browser
    if ENABLE_HEADLESS_CHROME
      set_headless_chrome
    end
    @browser ||= Pincers.for_webdriver(:chrome, wait_timeout: CHROME_CLIENT_TIMEOUT, options: @@options)
  end

  def set_headless_chrome
    @@options.add_argument('--headless')
>>>>>>> 8d34a4b... feat(lider-scraper): add lider scraper for products and headless Chrome
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
