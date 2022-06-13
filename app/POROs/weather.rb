class Weather
  attr_reader :summary, :temperature

  def initialize(data)
    @summary = data[:weather][0][:description]
    @temperature = format_temp(data[:temp])
  end

  def format_temp(temp)
    "#{temp.to_i} F"
  end
end
