require 'mechanize'
require 'json'
require 'pry'


categories = ['Juguetería_y_entretención', 'Mundo_Bebé']

lider_base_url = "https://www.lider.cl/catalogo/category"

agent = Mechanize.new
agent.user_agent_alias = "Linux Mozilla"



page = agent.get("https://www.lider.cl/catalogo/category/#{categories[1]}?page=1&hitsPerPage=100")

p page.body
puts
puts


products = page.search("//script")
data = JSON.parse(products[5])

data["itemListElement"].each do |item|
    puts "Nombre: #{item["item"]["name"]}"
    puts "Descripcion: #{item["item"]["description"]}"
    puts "SKU: #{item["item"]["sku"]}"
    puts "Marca: #{item["item"]["brand"]["name"]}"
    puts "Precio: #{item["item"]["offers"]["price"]}"
    puts "Moneda: #{item["item"]["offers"]["priceCurrency"]}"
    puts 
end





