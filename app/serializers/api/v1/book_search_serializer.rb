class Api::V1::BookSearchSerializer
  def self.weather_and_books(destination, weather, books)
    {
      data: {
        id: nil, 
        type: 'books',
        attributes: {
          destination: destination, 
          forecast: {
            summary: weather.summary,
            temperature: weather.temperature,
          },

          total_books_found: books.first.total_books_found,
          books: books.map do |book|
            {
              isbn: book.isbn,
              title: book.title,
              publisher: book.publisher,
            }
          end
        }
      }
    }
  end
end
