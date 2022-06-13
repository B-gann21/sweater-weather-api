class UnsplashService
  def self.conn
    Faraday.new('https://api.unsplash.com') do |f|
      f.params[:client_id] = ENV['unsplash_key']
    end
  end

  def self.search_for_background(city)
    response = conn.get('/search/photos') do |f|
      f.params[:query] = city
    end

    JSON.parse(response.body, symbolize_names: true)
  end
end
