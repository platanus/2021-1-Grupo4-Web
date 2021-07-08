class LiderClient
  BASE_URL = 'https://www.lider.cl/supermercado/search'
  MARKET_NAME = 'Lider'

  def products_by_query(query: nil)
    doc = Nokogiri::HTML(
      URI.parse(products_url(query)).open
    )

    products_found_to_json(doc)
  end

  private

  def products_found_to_json(doc)
    [{
      provider: { name: MARKET_NAME },
      products: products_found(doc)
    }]
  end

  def products_found(doc)
    doc.css('div[id^="productBox"]').map do |product|
      {
        price: get_price(product),
        quantity: get_quantity(product),
        measure: get_measure(product),
        package: get_package(product),
        name: get_name(product),
        img_url: get_image_url(product)
      }
    end.compact
  end

  def get_price(product)
    price = product.css('/div[2]/div[1]/div/span[2]/b').text.delete('$.')

    price.to_i
  end

  def get_quantity(product)
    product.css('/div[2]/div[1]/div/span[1]').text.split(' ').first.to_i
  end

  def get_measure(product)
    product.css('/div[2]/div[1]/div/span[1]').text.split(' ').second
  end

  def get_package(product)
    product.css('/div[2]/div[1]/div/span[1]').text
  end

  def get_name(product)
    product.css('/div[2]/div[1]/a/span[2]').text
  end

  def get_image_url(product)
    product.css('/div[1]/div[1]/a/div/img').attr('src').value
  end

  def products_url(query)
    url = "#{BASE_URL}?Ntt=#{query}"

    URI::DEFAULT_PARSER.escape(url)
  end
end
