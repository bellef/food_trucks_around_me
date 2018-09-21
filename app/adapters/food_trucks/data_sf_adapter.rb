# frozen_string_literal: true

module FoodTrucks
  class DataSfAdapter
    include HTTParty
    DATA_SF_APP_TOKEN = ENV['DATA_SF_APP_TOKEN']
    DATA_SF_BASE_URI = ENV['DATA_SF_BASE_URI']
    SELECTED_FIELDS = %w[
      Applicant
      Address
      LocationDescription
      Latitude
      Longitude
      FoodItems
      DaysHours
      Schedule
    ].freeze

    base_uri ENV['DATA_SF_BASE_URI']

    def food_trucks_around(location, radius_km)
      self.class.get(
        ENV['DATA_SF_BASE_PATH'],
        query: query,
        headers: headers
      )
    end

    private

    def query
      {
        '$select' => SELECTED_FIELDS.join(',')
      }
    end

    def headers
      {
        'X-App-Token' => DATA_SF_APP_TOKEN
      }
    end
  end
end
