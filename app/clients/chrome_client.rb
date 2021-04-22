require 'selenium-webdriver'

class ChromeClient
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
  end

  def ensuring_browser_closure(&block)
    block.call
  ensure
    browser&.close
    @browser = nil
  end
end
