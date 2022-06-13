FactoryBot.define do
  factory :hourly_forecast do
    datetime = Time.now.to_i
    temp = Faker::Number.decimal(l_digits: 2, r_digits: 2)
    conditions = ['rainy', 'snowy', 'sunny', 'cloudy'].sample
    icon = 'o1b'

    hash = {
      dt: datetime,
      temp: temp,
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
