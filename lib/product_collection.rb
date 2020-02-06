class ProductCollection
  # Константа со всеми возможными типами продуктов.
  # Это ассоциативный массив, где ключем является символ,
  # а значением - другой ассоциативный массив с названием папки,
  # и ссылкой на класс.
  PRODUCT_TYPES = {
      movie: {dir: 'films', class: Movie},
      book: {dir: 'books', class: Book},
      music: {dir: 'music', class: Drive}
  }

  # Конструктор коллекции принимает на вход массив продуктов,
  # но если нечего не передали на вход, то он записывает в переменную
  # экземпляра @products пустой массив.
  def initialize(products = [])
    @products = products
  end

  # Метод класса (статический метод) from_dir считывает из
  # указанной в параметрах папки все файлы:
  #
  # фильмы - из dir_path + '/films'
  # книги - из dir_path + '/books'
  # музыка - из dir_path + '/music'
  def self.from_dir(dir_path)
    # Создаем пустой массив, куда будем записывать все найденные продукты.
    products = []

    # Пройдемся по каждой паре ключ-значение из константы PRODUCT_TYPES и
    # поочередно запишем эту пару соответственно в переменные type и hash.
    #
    # Сначала в type будет :film, а в hash — {dir: 'films', class: Movie}, потом
    # в type будет :book, а в hash — {dir: 'books', class: Book}
    #
    PRODUCT_TYPES.each do |type, hash|
      # Получим из хэша путь к директории с файлами нужного типа, например,
      # строку 'films'
      product_dir = hash[:dir]

      # Получим из хэша объект нужного класса, например класс Film. Обратите
      # внимание, мы оперируем сейчас классом, как объектом. Передаем его по
      # ссылки и вызываем у него методы. Такова природа руби: все — объекты.
      product_class = hash[:class]

      # Для каждого текстового файла из директории, например '/data/films/'
      # берем путь к файлу и передаем его в метод класса from_file, вызывая его
      # у объекта нужного класса.
      Dir[dir_path + '/' + product_dir + '/*.txt'].each do |path|
        products << product_class.from_file_txt(path)
      end
    end

    # Вызываем конструктор этого же класса (ProductCollection) и передаем ему
    # заполненный массив продуктов
    self.new(products)
  end

  def to_a
    @products
  end

  # Данный метод принимает на вход ассоциативный массив, в котором могут быть два
  # ключа: :by и :order. Например, чтобы отсортировать продукты по возрастанию
  # цены, можно вызвать этот метод так:
  #
  # collection.sort!(by: :price, order: :asc)
  def sort!(params)
    case params[:by]
    when :name
      # Сортировка по наименованию
      @products.sort_by! { |product| product.name }
    when :price
      # Сортировка по цене
      @products.sort_by! { |product| product.price }
    when :amount
      # Сортировка по количеству
      @products.sort_by! { |product| product.amount }
    end

    # Если запросили сортировку по возрастанию
    @products.reverse! if params[:order] == :asc

    # Возвращаем ссылку на экземпляр, чтобы у него по цепочке можно было вызвать
    # другие методы.
    self
  end
end