class OpenWeatherMapService
  def self.conn
    Faraday.new('https://api.openweathermap.org') do |f|
      f.params[:appid] = ENV['open_weather_map_key']
    end
  end

  def self.get_forecast(coordinates)
    response = conn.get('/data/2.5/onecall') do |f|
      f.params[:lat] = coordinates[:lat]
      f.params[:lon] = coordinates[:lng]
      f.params[:units] = 'imperial'
    end

    JSON.parse(response.body, symbolize_names: true)
  end
end
