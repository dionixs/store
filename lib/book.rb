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

    @name = params[:name] if  params[:name]
    @genre = params[:genre] if params[:genre]
    @author = params[:author] if params[:author]
  end

  def to_s
    "Книга: «#{@name}», #{@genre}, автор - #{@author}, #{super}"
  end
end