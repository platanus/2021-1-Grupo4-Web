class LiderClient < ChromeClient
  BASE_URL = 'https://www.lider.cl/supermercado/search'

  def products_by_query(query: nil)
    ensuring_browser_closure do
      go_to_products_page(query)

      browser.search('.product-details').wait(:present, timeout: 5.0).map do |product|
        {
          brand: get_brand(product),
          offer_price: get_offer_price(product),
          normal_price: get_normal_price(product),
          measure: get_measure(product),
          name: get_name(product)
        }
      end
    end
  end

  private

  def get_offer_price(product)
    offer_price = product.search('.price-sell').text
    format_search(offer_price)
  end

  def get_normal_price(product)
    normal_price = product.search('.price-internet').text
    format_search(normal_price)
  end

  def get_measure(product)
    measure = product.search('.product-attribute').text
    format_search(measure)
  end

  def get_name(product)
    name = product.search('.product-description').text
    format_search(name)
  end

  def get_brand(product)
    brand = product.search('.product-name').text
    format_search(brand)
  end

  def format_search(result)
    result.presence ? result : nil
  end

  def go_to_products_page(query)
    browser.goto("#{BASE_URL}?Ntt=#{query}")
  end
end
