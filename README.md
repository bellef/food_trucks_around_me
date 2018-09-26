# FoodTrucksAroundMe

FoodTrucksAroundMe provides a service to find food trucks near a specific location.

Its documentation can be found [here](https://documenter.getpostman.com/view/498967/RWaRMQLk).

The postman collection is available at the root of the app.

## General information

- It's a `rails 5.2.1` app (api only mode)

- Hosted on [heroku](https://www.heroku.com/)

- Errors are monitored on Rollbar

- Tested using `rspec`

- It relies on [mapbox](https://www.mapbox.com/geocoding/) to geocode the address passed by the client (through the `geocoder` gem)

- It's a good living example of using the [adapter](https://en.wikipedia.org/wiki/Adapter_pattern) design pattern

- It does not rely on a database (but uses ActiveModel)

## Implementation details

1. The client sends a request with (at least) an `address` query parameter
2. Once the parameters are checked, the `SearchAroundAddressService` takes over
3. The address is geocoded using `geocoder` gem (we get its coordinates) and a `bounding_box` is calculated with the given radius (or the default one)
4. The `#food_trucks_within` is called on whatever `food_truck_client` we have (using the adapter pattern)
5. The raw data we get from the previous call gets deserialized (through the `DataSfDeserializer`) into an array of `FoodTruck` objects
6. These objects are serialized with the `FoodTruckSerializer` and rendered as json by the controller

## Installation

1. Clone the repository
2. Make sure you have `ruby '2.4.4'` installed
3. Run `bundle install`
4. Set the environment variables in a `.env` file and add it to your `.gitignore`
5. You're good to go!

### Environment variables

In order for this app to work, please make sure you have set the following environment variables:

```
DATA_SF_APP_TOKEN:        <your_data_sf_app_token>
DATA_SF_BASE_PATH:        /resource/6a9r-agq8.json
DATA_SF_BASE_URI:         https://data.sfgov.org
MAPBOX_API_KEY:           <your_mapbox_api_key>
ROLLBAR_ACCESS_TOKEN:     <your_rollbar_access_token>
```

## Next steps
- [ ] API versioning
- [ ] API authentication
- [ ] Caching of geocoded data (better scalability)
- [ ] Advanced search by food type, opening hours, etc.
- [ ] Add data sources for other locations (not only SF)

## Missing parts
- Front end app

As the [subject](https://gist.github.com/AlexisMontagne/8b2a2d8794da3979d4b8285f165b1f76) of the challenge stated:
> The goal of this code sample is to help us identify what you consider production-ready code. You should consider this code ready for final review with your colleague, i.e. this would be the last step before deploying to production.

My skills in front end frameworks are not good enough to send code into production without spending a lot of time on it so I decided not to do it rather than to do it badly.

If I were to do it, I would use some lightweight framework like Vue.js or something similar.
