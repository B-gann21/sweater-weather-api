class BackgroundFacade
  def self.find_background_image(city)
    raw_data = UnsplashService.search_for_background(city)

    Background.new(raw_data[:results][0], city)
  end
end
