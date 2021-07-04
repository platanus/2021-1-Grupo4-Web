class MarketClient < ChromeClient
  def products_by_query(query: nil)
    ensuring_browser_closure do
      go_to_products_page(query)

      products_found_to_json
    end
  rescue Pincers::ConditionTimeoutError
    []
  end

  private

  def products_found_to_json
    [
      {
        provider: 'provider',
        products: [
          {
            price: nil,
            quantity: nil,
            measure: nil,
            name: nil,
            img_url: nil
          }
        ]
      }
    ]
  end

  def products_found
    raise NotImplementedError, "#{__method__} is not defined for #{self.class.name}"
  end

  def get_price(_product)
    raise NotImplementedError, "#{__method__} is not defined for #{self.class.name}"
  end

  def get_old_price(_product)
    raise NotImplementedError, "#{__method__} is not defined for #{self.class.name}"
  end

  def get_offer_price(_product)
    raise NotImplementedError, "#{__method__} is not defined for #{self.class.name}"
  end

  def get_measure(_product)
    raise NotImplementedError, "#{__method__} is not defined for #{self.class.name}"
  end

  def get_name(_product)
    raise NotImplementedError, "#{__method__} is not defined for #{self.class.name}"
  end

  def format_search(result)
    result.presence ? result : nil
  end

  def products_url(_query)
    raise NotImplementedError, "#{__method__} is not defined for #{self.class.name}"
  end

  def go_to_products_page(query)
    browser.goto products_url(query)
  end
end
