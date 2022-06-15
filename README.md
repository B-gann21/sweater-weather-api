# Sweater Weather

The RESTful Rails API to return weather forecasts, background image URLs, and road trip information based on a given location.

*this project uses the [Unsplash](https://unsplash.com/documentation), [Open Weather Map (One Call Api 3.0)](https://openweathermap.org/api), and [MapQuest](https://developer.mapquest.com/documentation) APIs. 
You will need to create an account with these 3 sources to have your own API keys.*

*note this project is not in production. It is only useable on localhost*

## Learning Goals

* Expose an API that aggregates data from multiple external APIs
* Expose an API that requires an authentication token
* Expose an API for CRUD functionality
* Research, select, and consume an API based on your needs as a developer

### Versions / Dependencies
* Ruby version 2.7.4
* Rails version 5.2.8
* PostgreSQL

### Local Setup
* fork then clone this repo, and `cd` into the new folder
* `bundle install` to get all the required gems
* `bundle exec figaro install` to generate an application.yml file
* assign the following `key: value` pairs inside of application.yml:
  * `map_quest_key: {your map quest api key}`
  * `open_weather_map_key: {your open weather map api key}`
  * `unsplash_key: {your open weather map key}`
* `rails db:{create,migrate}` to establish the database 
*  `rails s` to boot up the server
*  make some requests in Postman!

## Endpoints available from Sweater Weather

* `GET /api/v1/forecast?location={query}` - Returns a Forecast response which has robust data on the current, hourly, and daily weather of a given location.
* Example request: `GET /api/v1/forecast&location=denver,co`
* Example response:
```
{
  "data": {
    "id": null,
    "type": "forecast",
    "attributes": {
       "current_weather": {
          "datetime": "2022-06-14T21:21:04.000-06:00",
          "sunrise": "2022-06-14T05:31:26.000-06:00",
          "sunset": "2022-06-14T20:29:10.000-06:00",
          "temperature": 70.43,
          "feels_like": 68.81,
          "humidity": 35,
          "uvi": 0,
          "visibility": 10000,
          "conditions": "few clouds",
          "icon": "02n"
      },
      "daily_weather": [
         {
           "date": "06/14/22",
           "sunrise": "2022-06-14T05:31:26.000-06:00",
           "sunset": "2022-06-14T20:29:10.000-06:00",
           "max_temp": 86.83,
           "min_temp": 61.23,
           "conditions": "few clouds",
           "icon": "02d"
         },
         {
           "date": "06/15/22",
           "sunrise": "2022-06-15T05:31:27.000-06:00",
           "sunset": "2022-06-15T20:29:34.000-06:00",
           "max_temp": 88.25,
           "min_temp": 56.08,
           "conditions": "clear sky",
           "icon": "01d"
         },
         {...}
     ],
     "hourly_weather": [
         {
            "time": "2022-06-14T21:00:00.000-06:00",
            "temperature": 70.43,
            "conditions": "few clouds",
            "icon": "02n"
         },
         {
            "time": "2022-06-14T22:00:00.000-06:00",
            "temperature": 69.85,
            "conditions": "clear sky",
            "icon": "01n"
         },
         {...}
       ]
     }
  }
}
```

* `GET api/v1/backgrounds?location={query}` - searches Unsplash for the first image that matched the given location and returns the image URL
* Example request: `GET 'api/v1/backgrounds?location=denver,co'`
* Example response:
```
{
  "data": {
    "id": null,
    "type": "image",
    "attributes": {
      "image": {
        "location": "denver,co",
        "image_url": "https://images.unsplash.com/photo-1629163330223-c183571735a1?crop=entropy&cs=tinysrgb&fm=jpg&ixid=MnwzMzY2Mjh8MHwxfHNlYXJjaHwxfHxkZW52ZXIlMkNjb3xlbnwwfHx8fDE2NTUxMzMyMDU&ixlib=rb-1.2.1&q=80",
        "credit": {
          "source": "unsplash.com",
          "author": "Taylor Daugherty"
        }
      }
    }
  }
}
```

* `POST /api/v1/users` - simulates registering a User in the database. Requires the `CONTENT_TYPE` header to be set to `application/json`, and a JSON payload in the following format passed in the body. Returns the User for a frontend to render.
* Example request: 
```
POST /api/v1/users

HEADERS: 
Content-Type: application/json 

JSON PAYLOAD: 
{
  "email": "whatever@example.com",
  "password": "password",
  "password_confirmation": "password"
}
```
* Example response: 
```
{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "whatever@example.com",
      "api_key": "jgn983hy48thw9begh98h4539h4"
    }
  }
}
```

* `POST api/v1/sessions` - simulates logging in as an existing user. Requires the `CONTENT_TYPE` header to be set to `application/json`, and a JSON payload in the following format passed in the body. Returns the User for a frontend to render.
* Example request: 
```
POST /api/v1/sessions

HEADERS:
Content-Type: application/json

JSON PAYLOAD:
{
  "email": "whatever@example.com",
  "password": "password"
}
```
* Example response: 
```
{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "whatever@example.com",
      "api_key": "jgn983hy48thw9begh98h4539h4"
    }
  }
}
```

* `POST api/v1/road_trip` - returns data on the travel time to a given destination, as well as the weather forecast for the arrival time. Requires the `CONTENT_TYPE` header to be set to `application/json`, and a JSON payload in the following format passed in the body. The `api_key` must match an api key of an already registered User.
* Example request: 
```
POST /api/v1/road_trip

HEADERS:
Content-Type: application/json

JSON PAYLOAD
{
  "origin": "Denver,CO",
  "destination": "Pueblo,CO",
  "api_key": "jgn983hy48thw9begh98h4539h4"
}
```
* Example response:
```
{
  "data": {
    "id": null,
    "type": "roadtrip",
    "attributes": {
      "start_city": "Denver, CO",
      "end_city": "Estes Park, CO",
      "travel_time": "2:13:45"
      "weather_at_eta": {
        "temperature": 59.4,
        "conditions": "partly cloudy with a chance of meatballs"
      }
    }
  }
}
```
