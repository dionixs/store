class Movie < Product
  attr_accessor :name, :year, :director

  def self.from_file(path_to_file)
    file = File.open(path_to_file, 'r:UTF-8')
    content = file.readlines
    content.each(&:strip!)

    new(
        name: content[0],
        director: content[1],
        year: content[2].to_i,
        price: content[3].to_i,
        amount: content[4].to_i
    )
  end

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

  def to_s
    "Фильм «#{@name}», #{@year}, реж. #{@director}, #{super}"
  end
end
