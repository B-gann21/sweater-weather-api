class OpenLibraryService
  def self.conn
    Faraday.new('http://openlibrary.org')
  end

  def self.get_books(location)
    response = conn.get('/search.json') do |f|
      f.params[:q] = location
    end
  end
end
