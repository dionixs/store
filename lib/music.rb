class Music < Product
  attr_accessor :artist, :name, :genre

  def self.from_file(path_to_file)
    file = File.open(path_to_file, 'r:UTF-8')
    content = file.readlines
    content.each(&:strip!)

    self.new(
        artist: content[0],
        name: content[1],
        genre: content[2],
        price: content[3].to_i,
        amount:  content[4].to_i
    )
  end

  def initialize(params)
    super

    @artist = params[:artist]
    @name = params[:name]
    @genre = params[:genre]
  end

  def update(params)
    super

    @artist = params[:artist] if params[:artist]
    @name = params[:title] if params[:name]
    @genre = params[:genre] if params[:genre]
  end

  def to_s
    "Диск #{@artist} — #{@name} (#{@genre}) — #{@price} руб. [осталось: #{@amount}]"
  end
end