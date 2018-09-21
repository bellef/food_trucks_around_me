# frozen_string_literal: true

module FoodTrucks
  module Deserializers
    class DataSfDeserializer
      # Takes raw data from DataSf and returns a FoodTruck object
      def self.deserialize(raw_item)
        FoodTruck.new(
          address:              raw_item['Address'],
          name:                 raw_item['Applicant'],
          location_description: raw_item['LocationDescription'],
          latitude:             Float(raw_item['Latitude']),
          longitude:            Float(raw_item['Longitude']),
          food_items:           raw_item['FoodItems'],
          schedule:             raw_item['DaysHours'],
          schedule_url:         raw_item['Schedule']
        )
      end

      def self.deserialize_collection(raw_items)
        raw_items.map { |raw_item| deserialize(raw_item) }
      end
    end
  end
end
