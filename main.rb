require_relative 'lib/product'
require_relative 'lib/book'
require_relative 'lib/movie'

movie = Movie.new(
    name: "Леон",
    year: 1994,
    director: "Люк Бессон",
    price: 990,
    amount: 10
)

movie.year = 1998
movie.update(amount: 5)

book = Book.new(
    name: "Идиот",
    genre: "Роман",
    author: "Федор Достоевский",
    price: 1700,
    amount: 10
)

book.amount = 20
book.update(author: 'Достоевский', price: 1800)

puts movie
puts book


