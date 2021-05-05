class JumboClient < MarketClient
  BASE_URL = 'https://www.jumbo.cl/busqueda'
  MARKET_NAME = 'Jumbo'

  private

  def products_found_to_json
    products_found.map do |product|
      price = get_price(product) || get_old_price(product) || get_offer_price(product)
      next if price.blank?

      {
        price: price,
        measure: get_measure(product),
        name: get_name(product),
        provider: MARKET_NAME
      }
    end.compact
  end

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
    price = product.search('.price-product-best').first
    return if price.blank?

    format_search(price.text)
  end

  def get_measure(product)
    measure = product.search('.shelf-single-unit').text
    format_search(measure)
  end

  def get_name(product)
    name = product.search('.shelf-product-title h2').first.text
    format_search(name)
  end

  def products_page(query)
    "#{BASE_URL}?ft=#{query}"
  end
end
