FactoryBot.define do
  factory :current_forecast do
    datetime    = Time.now
    sunrise     = Time.now - 3.hours
    sunset      = Time.now + 10.hours
    temperature = Faker::Number.decimal(l_digits: 2, r_digits: 2)
    feels_like  = Faker::Number.decimal(l_digits: 2, r_digits: 2)
    humidity    = Faker::Number.within(range: 0..100)
    uvi         = Faker::Number.decimal(l_digits: 1, r_digits: 2)
    visibility  = Faker::Number.within(range: 0..10000)
    conditions  = ['rainy', 'cloudy', 'sunny', 'snow'].sample
    icon        = '01a'

    hash = {
      dt: datetime.to_i,
      sunrise: sunrise.to_i,
      sunset: sunset.to_i,
      temp: temperature,
      feels_like: feels_like,
      humidity: humidity,
      uvi: uvi,
      visibility: visibility,
      weather: [
        {
          description: conditions,
          icon: icon,
        }
      ]
    }  

    initialize_with { new(hash) }
  end
end
