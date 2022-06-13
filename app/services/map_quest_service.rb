class MapQuestService
  def self.get_city_info(city)
    response = conn.get('/geocoding/v1/address') do |f|
      f.params[:location] = city
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new('http://www.mapquestapi.com') do |f|
      f.params[:key] = ENV['map_quest_key']
    end
  end
end
