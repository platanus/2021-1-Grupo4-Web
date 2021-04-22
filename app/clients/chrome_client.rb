class ChromeClient
  CHROME_CLIENT_TIMEOUT = 35

  def browser
    @browser ||= Pincers.for_webdriver(:chrome, wait_timeout: CHROME_CLIENT_TIMEOUT)
  end

  def ensuring_browser_closure(&block)
    block.call
  ensure
    browser&.close
    @browser = nil
  end
end
