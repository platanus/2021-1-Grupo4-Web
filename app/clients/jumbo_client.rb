class JumboClient < ChromeClient
  BASE_URL = 'https://www.jumbo.cl/busqueda'

  def products_by_query(query: nil)
    ensuring_browser_closure do
      go_to_products_page(query)

      browser.search('.shelf-item').wait(:present, timeout: 5.0).map do |product|
        {
          price: get_price(product),
          measure: get_measure(product),
          name: get_name(product)
        }
      end
    end
  end

  private

  def get_price(product)
    product.search('.product-single-price-container').text.split('\n').first
  end

  def get_measure(product)
    product.search('.shelf-single-unit').text
  end

  def get_name(product)
    product.search('.shelf-product-title h2').first.text
  end

  def go_to_products_page(query)
    browser.goto("#{BASE_URL}?ft=#{query}")
  end
end
