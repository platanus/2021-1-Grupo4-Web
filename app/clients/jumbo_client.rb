class JumboClient < ChromeClient
  BASE_URL = 'https://www.jumbo.cl/busqueda'

  def products_by_query(query: nil)
    ensuring_browser_closure do
      go_to_products_page(query)

      products_found.map do |product|
        {
          price: get_price(product) || get_old_price(product) || get_offer_price(product),
          measure: get_measure(product),
          name: get_name(product),
          provider: 'Jumbo'
        }
      end
    end
  rescue Pincers::ConditionTimeoutError
    []
  end

  private

  def products_found
    browser.search('.shelf-item').wait(:present, timeout: 10.0)
  end

  def get_price(product)
    price = product.search('.product-single-price-container').text.split("\n").first
    format_search(price)
  end

  def get_old_price(product)
    price = product.search('.price-product-value').text
    format_search(price)
  end

  def get_offer_price(product)
    price = product.search('.price-product-best').first.text
    format_search(price)
  end

  def get_measure(product)
    measure = product.search('.shelf-single-unit').text
    format_search(measure)
  end

  def get_name(product)
    name = product.search('.shelf-product-title h2').first.text
    format_search(name)
  end

  def format_search(result)
    result.presence ? result : nil
  end

  def go_to_products_page(query)
    browser.goto "#{BASE_URL}?ft=#{query}"
  end
end
