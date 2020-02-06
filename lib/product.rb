# frozen_string_literal: true

class Product
  attr_accessor :price, :amount

  def self.types
    [Book, Movie, Drive]
  end

  def initialize(params)
    @price = params[:price]
    @amount = params[:amount]
  end

  def update(params)
    @price = params[:price] if params[:price]
    @amount = params[:amount] if params[:amount]
  end

  def to_s
    "#{@price} руб. [осталось: #{@amount}]"
  end

  def self.from_file_txt(_path_to_file)
    # медод raise генерирует исключение, при вызове: Product.from_file(path_to_file)
    raise NotImplementedError # ошибка реализации метода
  end

  def self.showcase(products)
    puts "Что хотите купить?\n\n"

    products.to_a.each_with_index do |item, index|
      puts "#{index}: #{item}"
    end

    puts "x: Покинуть магазин\n\n"
  end

  def buy
    if @amount > 0
      puts '* * *'
      puts "Вы купили товар #{self}"
      puts "* * *\n\n"

      @amount -= 1
      @price
    else
      puts 'К сожалению, больше нет'
      0
    end
  end

  def self.read_from_xml(path_to_file)
    abort 'Файл products.xml не найден!' unless File.exist?(path_to_file)

    file = File.open(path_to_file)
    doc = REXML::Document.new(file)
    file.close

    products = []

    ['products/books/*', 'products/movies/*', 'products/drives/*'].each do |xpath|
      doc.elements.each(xpath) do |item|
        if item.to_s.include?('book')
          params = {}

          params[:name] = item.text.strip
          params[:author] = item.attributes['author']
          params[:genre] = item.attributes['genre']
          params[:price] = item.attributes['price'].to_i
          params[:amount] = item.attributes['amount'].to_i

          products << Book.new(params)
        end

        if item.to_s.include?('movie')
          params = {}

          params[:name] = item.text.strip
          params[:year] = item.attributes['year'].to_i
          params[:director] = item.attributes['director']
          params[:price] = item.attributes['price'].to_i
          params[:amount] = item.attributes['amount'].to_i

          products << Movie.new(params)
        end

        next unless item.to_s.include?('drive')

        params = {}

        params[:name] = item.text.strip
        params[:artist] = item.attributes['artist']
        params[:genre] = item.attributes['genre']
        params[:price] = item.attributes['price'].to_i
        params[:amount] = item.attributes['amount'].to_i

        products << Drive.new(params)
      end
    end
    products
  end

  def self.choice_type_product(types)
    user_input = nil

    loop do
      puts 'Какой товар вы хотите выбрать?'
      types.each_with_index do |item, index|
        puts "#{index}: #{item}"
      end
      user_input = STDIN.gets.to_i
      break if (0..types.size).include?(user_input)
    end

    type = types[user_input]

    params = Product.add_product.merge(type.add_product)

    type.new(params)
  end

  def self.add_product
    puts 'Укажите стоимость продукта в рублях'
    price = STDIN.gets.to_i

    puts 'Укажите, сколько единиц продукта осталось на склад'
    amount = STDIN.gets.to_i

    params = {}

    params[:price] = price
    params[:amount] = amount

    params
  end

  def to_xml; end

  def save_to_xml(path_to_file)
    # если файл не существует, то он будет создан.
    unless File.exist?(path_to_file)
      File.open(path_to_file, 'w:UTF-8') do |file|
        file.puts "<?xml version='1.0' encoding='UTF-8'?>"
        file.puts '<products>'
        file.puts "\t<books></books>"
        file.puts "\t<movies></movies>"
        file.puts "\t<drives></drives>"
        file.puts '</products>'
      end
    end

    file = File.new(path_to_file, 'r:UTF-8')

    begin
      doc = REXML::Document.new(file)
    rescue REXML::ParseException => e
      puts 'XML файл поврежден!'
      abort e.message
    end

    file.close

    tag = self.to_xml

    if tag.to_s.include?('book')
      doc.root.elements['books'].add_element(tag)
    elsif tag.to_s.include?('movie')
      doc.root.elements['movies'].add_element(tag)
    elsif tag.to_s.include?('drive')
      doc.root.elements['drives'].add_element(tag)
    end

    File.open(path_to_file, 'w:UTF-8') do |file|
      doc.write(file, 2)
    end

    puts 'Товар добавлен!'
  end
end
