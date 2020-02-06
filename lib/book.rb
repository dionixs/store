# frozen_string_literal: true

class Book < Product
  attr_accessor :name, :genre, :author

  def initialize(params)
    super

    @name = params[:name]
    @genre = params[:genre]
    @author = params[:author]
  end

  def update(params)
    super

    @name = params[:name] if params[:name]
    @genre = params[:genre] if params[:genre]
    @author = params[:author] if params[:author]
  end

  def self.from_file_txt(path_to_file)
    file = File.open(path_to_file, 'r:UTF-8')
    content = file.readlines
    content.each(&:strip!)

     self.new(
      name: content[0],
      genre: content[1],
      author: content[2],
      price: content[3].to_i,
      amount: content[4].to_i
    )
  end

  def self.add_product
    puts 'Укажите название книги'
    name = STDIN.gets.strip

    puts 'Укажите жанр'
    genre = STDIN.gets.strip

    puts 'Укажите автора'
    author = STDIN.gets.strip

    params = {}

    params[:name] = name
    params[:genre] = genre
    params[:author] = author

    params
  end

  def to_xml
    tag = REXML::Element.new

    book = tag.add_element('book',
                           'author' => @author,
                           'genre' => @genre,
                           'price' => @price,
                           'amount' => @amount)

    book.text = @name

    book
  end

  def save_to_xml(path_to_file)
    super
  end

  def to_s
    "Книга: «#{@name}», #{@genre}, автор - #{@author}, #{super}"
  end
end
