class LiderClient < MarketClient
  BASE_URL = 'https://www.lider.cl/supermercado/search'
  MARKET_NAME = 'Lider'

  private

  def products_found_to_json
    products_found.map do |product|
      {
        price: get_price(product) || get_offer_price(product),
        measure: get_measure(product),
        name: get_name(product),
        provider: MARKET_NAME
      }
    end
  end

  def products_found
    browser.search('.product-details').wait(:present, timeout: 5.0)
  end

  def get_price(product)
    normal_price = product.search('.price-internet').text
    format_search(normal_price)
  end

  def get_offer_price(product)
    offer_price = product.search('.price-sell').text
    format_search(offer_price)
  end

  def get_measure(product)
    measure = product.search('.product-attribute').text
    format_search(measure)
  end

  def get_name(product)
    name = product.search('.product-description').text
    format_search(name)
  end

  def products_page(query)
    "#{BASE_URL}?Ntt=#{query}"
  end
end
