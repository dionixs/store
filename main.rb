require_relative 'lib/product'
require_relative 'lib/book'
require_relative 'lib/movie'

products = []

products << Movie.new(
    name: "Леон",
    year: 1994,
    director: "Люк Бессон",
    price: 990,
    amount: 10
)

products << Movie.new(
    name: "Дурак",
    year: 2014,
    director: "Юрий Быков",
    price: 500,
    amount: 1
)

products << Book.new(
    name: "Идиот",
    genre: "Роман",
    author: "Федор Достоевский",
    price: 1700,
    amount: 10
)

puts "Вот какие товары у нас есть:\n\n"

products.each do |item|
  puts item
end

