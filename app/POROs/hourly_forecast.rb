class HourlyForecast
  attr_reader :datetime, :temperature, :conditions, :icon

  def initialize(data)
    @datetime = Time.at(data[:dt])
    @temperature = data[:temp]
    @conditions = data[:weather][0][:description]
    @icon = data[:weather][0][:icon]
  end
end
