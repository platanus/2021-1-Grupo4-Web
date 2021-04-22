class LiderClient < ChromeClient
    BASE_URL = 'https://www.lider.cl/supermercado/search?Ntt='
  
    def products_by_query(query: nil)
      ensuring_browser_closure do
        go_to_products_page(query)
        
        scraped_products = []
        browser.search('.product-details').wait(:present, timeout: 5.0).map do |product|
          scraped_products.push({
            brand: get_brand(product),
            offer_price: get_offer_price(product),
            normal_price: get_normal_price(product),
            measure: get_measure(product),
            name: get_name(product)
          })
          puts scraped_products.last
        end
      end
    end
  
    private
  
    def get_offer_price(product)
      product.search('.price-sell').text
    end

    def get_normal_price(product)
      product.search('.price-internet').text
    end
  
    def get_measure(product)
      product.search('.product-attribute').text
    end
  
    def get_name(product)
      product.search('.product-description').text
    end

    def get_brand(product)
      product.search('.product-name').text
    end
  
    def go_to_products_page(query)
      browser.goto(BASE_URL + query)
    end
  end