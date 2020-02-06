# frozen_string_literal: true

class Movie < Product
  attr_accessor :name, :year, :director

  def initialize(params)
    super

    @name = params[:name]
    @year = params[:year]
    @director = params[:director]
  end

  def update(params)
    super

    @name = params[:name] if params[:name]
    @year = params[:year] if params[:year]
    @director = params[:director] if params[:director]
  end

  def self.from_file_txt(path_to_file)
    file = File.open(path_to_file, 'r:UTF-8')
    content = file.readlines
    content.each(&:strip!)

    self.new(
      name: content[0],
      director: content[1],
      year: content[2].to_i,
      price: content[3].to_i,
      amount: content[4].to_i
    )
  end

  def self.add_product
    puts 'Укажите название фильма'
    name = STDIN.gets.strip

    puts 'Укажите имя режиссера'
    director = STDIN.gets.strip

    puts 'Укажите год'
    year = STDIN.gets.to_i

    params = {}

    params[:name] = name
    params[:director] = director
    params[:year] = year

    params
  end

  def to_xml
    tag = REXML::Document.new

    movie = tag.add_element('movie',
                            'director' => @director,
                            'year' => @year,
                            'price' => @price,
                            'amount' => @amount)

    movie.text = @name

    movie
  end

  def save_to_xml(path_to_file)
    super
  end

  def to_s
    "Фильм «#{@name}», #{@year}, реж. #{@director}, #{super}"
  end
end
