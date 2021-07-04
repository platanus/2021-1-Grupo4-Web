class JumboClient < MarketClient
  BASE_URL = 'https://www.jumbo.cl/busqueda'
  MARKET_NAME = 'Jumbo'
  MAX_PRODUCTS = 4

  private

  def products_found_to_json
    [{
      provider: { name: MARKET_NAME },
      products: parsed_products
    }]
  end

  def parsed_products
    products_found.map do |product|
      price = get_price(product) || get_old_price(product) || get_offer_price(product)
      next if price.blank?

      {
        price: price.delete('$ .').to_i,
        package: get_package(product),
        quantity: get_quantity(product),
        measure: get_measure(product),
        name: get_name(product),
        img_url: get_img_url(product)
      }
    end.compact
  end

  def products_found
    browser.search('.shelf-item').wait(:present, timeout: 10.0).to_a.first(MAX_PRODUCTS)
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

  def get_package(product)
    package = product.search('.shelf-single-unit').text
    format_search(package)
  end

  def get_quantity(product)
    quantity = product.search('.shelf-single-unit').text.split(' ').first.to_i
    format_search(quantity)
  end

  def get_measure(product)
    measure = product.search('.shelf-single-unit').text.split(' ').second
    MeasuresService.map_measure(format_search(measure))
  end

  def get_name(product)
    name = product.search('.shelf-product-title h2').first.text
    format_search(name)
  end

  def get_img_url(product)
    img_container = product.search('.lazy-image').wait(:present, timeout: 2.0).first

    img_container.attribute('src')
  rescue StandardError
    nil
  end

  def products_url(query)
    "#{BASE_URL}?ft=#{query}"
  end
end
