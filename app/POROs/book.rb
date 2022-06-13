class Book
  attr_reader :isbn, :title, :publisher, :total_books_found

  def initialize(data)
    @isbn = data[:isbn]
    @title = data[:title]
    @publisher = data[:publisher]
    @total_books_found = data[:numFound]
  end
end
