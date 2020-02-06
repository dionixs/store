class Drive < Product
  attr_accessor :artist, :name, :genre

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

  def self.from_file_txt(path_to_file)
    file = File.open(path_to_file, 'r:UTF-8')
    content = file.readlines
    content.each(&:strip!)

    self.new(
        artist: content[0],
        name: content[1],
        genre: content[2],
        price: content[3].to_i,
        amount: content[4].to_i
    )
  end

  def self.add_product
    puts "Укажите название исполнителя"
    artist = STDIN.gets.strip

    puts "Укажите название альбома"
    name = STDIN.gets.strip

    puts "Укажите музыкальный жанр"
    genre = STDIN.gets.strip

    params = Hash.new

    params[:artist] = artist
    params[:name] = name
    params[:genre] = genre

    return params
  end

  def to_xml
    tag = REXML::Document.new

    drive = tag.add_element('drive',
                           'artist' => @artist,
                           'genre' => @genre,
                           'price' => @price,
                           'amount' => @amount
    )

    drive.text = @name

    return drive
  end

  def save_to_xml(path_to_file)
    super
  end

  def to_s
    "Диск #{@artist} — #{@name} (#{@genre}) — #{super}"
  end
end