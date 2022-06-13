class CurrentForecast
  attr_reader :datetime, :sunrise, :sunset,
              :temperature, :feels_like, :humidity,
              :uvi, :visibility, :conditions, :icon

  def initialize(data)
    @datetime = Time.at(data[:dt])
    @sunrise = Time.at(data[:sunrise])
    @sunset = Time.at(data[:sunset])
    @temperature = data[:temp]
    @feels_like = data[:feels_like]
    @humidity = data[:humidity]
    @uvi = data[:uvi]
    @visibility = data[:visibility]
    @conditions = data[:weather][0][:conditions]
    @icon = data[:weather][0][:icon]
  end
end
