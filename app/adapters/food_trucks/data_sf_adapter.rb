# frozen_string_literal: true

module FoodTrucks
  class DataSfAdapter
    include HTTParty

    base_uri ENV['DATA_SF_BASE_URI']

    # bounding_box:
    # An array representing the bounds of the search area
    #   and containing the coordinates of the southwest
    #   and northeast corners of the box
    def food_trucks_within(bounding_box)
      @bounding_box = bounding_box

      response = self.class.get(
        ENV['DATA_SF_BASE_PATH'],
        query: query,
        headers: headers
      )
      return response if response.success?
      raise CustomErrors::Api::ThirdPartyApiError.new(message: 'An error occured with the DataSf API, please contact the service administrator or see the logs if you are the administrator.', code: 500, data: response)
    end

    private

    attr_reader :bounding_box

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

    def query
      {
        '$select' => SELECTED_FIELDS.join(','),
        '$where' => "Latitude between #{south_west_lat} AND #{north_east_lat} AND Longitude between #{south_west_lng} AND #{north_east_lng}"
      }
    end

    def headers
      {
        'X-App-Token' => ENV['DATA_SF_APP_TOKEN']
      }
    end

    def south_west_lat
      bounding_box[0]
    end

    def south_west_lng
      bounding_box[1]
    end

    def north_east_lat
      bounding_box[2]
    end

    def north_east_lng
      bounding_box[3]
    end
  end
end
