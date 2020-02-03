class Product
  attr_accessor :price, :amount

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

  def self.from_file_txt(path_to_file)
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
      puts "* * *"
      puts "Вы купили товар #{to_s}"
      puts "* * *\n\n"

      @amount -= 1
      @price
    else
      puts "К сожалению, больше нет"
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
          params = Hash.new

          params[:name] = item.text
          params[:author] = item.attributes['author']
          params[:genre] = item.attributes['genre']
          params[:price] = item.attributes['price'].to_i
          params[:amount] = item.attributes['amount'].to_i

          products << Book.new(params)
        end

        if item.to_s.include?('movie')
          params = Hash.new

          params[:name] = item.text
          params[:year] = item.attributes['year'].to_i
          params[:director] = item.attributes['director']
          params[:price] = item.attributes['price'].to_i
          params[:amount] = item.attributes['amount'].to_i

          products << Movie.new(params)
        end

        if item.to_s.include?('drive')
          params = Hash.new

          params[:name] = item.text
          params[:artist] = item.attributes['artist']
          params[:genre] = item.attributes['genre']
          params[:price] = item.attributes['price'].to_i
          params[:amount] = item.attributes['amount'].to_i

          products << Music.new(params)
        end
      end
    end
    return products
  end
end
