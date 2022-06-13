class DailyForecast
  attr_reader :date, :sunrise, :sunset,
              :max_temp, :min_temp,
              :conditions, :icon

  def initialize(data)
    @date = unix_to_date(data[:dt])
    @sunrise = Time.at(data[:sunrise])
    @sunset = Time.at(data[:sunset])
    @max_temp = data[:temp][:max]
    @min_temp = data[:temp][:min]
    @conditions = data[:weather][0][:description]
    @icon = data[:weather][0][:icon]
  end

  def unix_to_date(unix)
    Time.at(unix).strftime('%D')
  end
end
