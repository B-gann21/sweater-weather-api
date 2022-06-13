class BookSearchFacade
  def self.find_weather_and_books(location, limit)
    books_data = OpenLibraryService.get_books(location)
    coordinates = MapQuestService.get_city_info(location)
    weather_data = OpenWeatherMapService.get_forecast(coordinates)
    current_temp = weather_data[:current][:temp]
    current_desc = weather_data[:current][:weather][0][:description]

    weatherBooks = {}
    weatherBooks[:weather] = Weather.new(current_temp, current_desc)
    weatherBooks[:books] = books_data[:docs][0..limit - 1].map { |book_data| Book.new(book_data) }
    weatherBooks
  end
end
