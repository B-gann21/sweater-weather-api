class BookSearchFacade
  def self.find_weather_and_books(location, limit)
    books_data = OpenLibraryService.get_books(location)
    coordinates = MapQuestService.get_city_info(location)[:results][0][:locations][0][:latLng]
    weather_data = OpenWeatherMapService.get_forecast(coordinates)[:current]

    weatherBooks = {}
    weatherBooks[:weather] = Weather.new(weather_data)
    weatherBooks[:books] = books_data[:docs][0..limit.to_i - 1].map { |book_data| Book.new(book_data) }
    weatherBooks
  end
end
