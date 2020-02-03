require 'rexml/document'

require_relative 'lib/product'
require_relative 'lib/book'
require_relative 'lib/movie'
require_relative 'lib/music'
require_relative 'lib/product_collection'

total_price = 0

products = Product.read_from_xml(File.dirname(__FILE__) + '/data/products.xml')

choice = nil

loop do
  Product.showcase(products)

  choice = STDIN.gets.chomp

  if choice != 'x' && choice.to_i < products.size && choice.to_i >= 0
    product = products[choice.to_i]
    product.buy
    total_price += product.price
  end

  break if choice == 'x'
end

puts "Спасибо за покупки, с Вас #{total_price} руб."
