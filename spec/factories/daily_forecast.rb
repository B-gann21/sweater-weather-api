FactoryBot.define do 
  factory :daily_forecast do
    date = Time.now.to_i
    sunrise = (Time.now - 3.hours).to_i
    sunset = (Time.now + 10.hours).to_i
    max_temp = Faker::Number.decimal(l_digits: 2, r_digits: 2)
    min_temp = Faker::Number.decimal(l_digits: 2, r_digits: 2)
    conditions = ['snowy', 'rainy', 'cloudy', 'sunny'].sample
    icon = 'o1a'

    hash = {
      dt: date,
      sunrise: sunrise,
      sunset: sunset,
      temp: {
        max: max_temp,
        min: min_temp,
      },
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
