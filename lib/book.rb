class Book < Product
  attr_accessor :name, :genre, :author

  def self.from_file(path_to_file)
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

  def to_s
    "Книга: «#{@name}», #{@genre}, автор - #{@author}, #{super}"
  end
end
