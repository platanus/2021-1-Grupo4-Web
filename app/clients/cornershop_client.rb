class CornershopClient
  BASE_URL = 'https://cornershopapp.com/api/v2/branches/search'
  DEFAULT_COUNTRY_CODE = 'CL'

  def products_by_query(query: nil, locality: 'Providencia')
    response = HTTParty.get(
      products_url(query, locality)
    )

    products_found_to_json(response['results'])
  end

  private

  def products_found_to_json(stores)
    products = []
    stores.each do |store_result|
      store = store_result['store']
      store_search_result = store_result['search_result']['aisles'].first

      provider_name = get_store_name(store)

      products << {
        provider: { name: provider_name },
        products: products_found_by_store(store_search_result)
      }
    end

    products.flatten
  end

  def products_found_by_store(store_search_result)
    store_search_result['products'].map do |product|
      next unless product['purchasable']

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
    price = product['original_price'] || product['price']

    price.to_i
  end

  def get_measure(product)
    MeasuresService.map_measure(package(product).split(' ').second)
  end

  def get_quantity(product)
    quantity = package(product).split(' ').first.to_f

    quantity.zero? ? 1 : quantity
  end

  def package(product)
    elements = product['package']&.split(' ')
    return '1 Unidad' unless elements&.count&.between?(2, 3)

    elements.last(2).join(' ')
  end

  def get_package(product)
    product['package']
  end

  def get_name(product)
    return product['name'] if product['brand'].blank?

    "#{product['brand']['name']} - #{product['name']}"
  end

  def get_image_url(product)
    product['img_url']
  end

  def get_store_name(store)
    store['name']
  end

  def products_url(query, locality)
    url = "#{BASE_URL}?query=#{query}&country=#{DEFAULT_COUNTRY_CODE}&locality=#{locality}"

    URI::DEFAULT_PARSER.escape(url)
  end
end
