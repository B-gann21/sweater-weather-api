class Background
  attr_reader :location, :image_url, :source, :author

  def initialize(data, location)
    @location = location
    @image_url = data[:urls][:full]
    @source = 'unsplash.com'
    @author = data[:user][:name]
  end
end
