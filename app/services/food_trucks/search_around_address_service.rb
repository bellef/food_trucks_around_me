# frozen_string_literal: true

module FoodTrucks
  class SearchAroundAddressService
    DEFAULT_RADIUS_KM = Rails.configuration.search_default_radius_km

    def initialize(address, radius_km = nil)
      @address = address
      @radius_km = radius_km.blank? ? DEFAULT_RADIUS_KM : radius_km
    end

    def process
      raw_items = if search_address_coordinates.nil?
                    []
                  else
                    food_trucks_client.food_trucks_within(bounding_box)
                  end
      Deserializers::DataSfDeserializer.deserialize_collection(raw_items)
    end

    private

    attr_reader :address, :radius_km

    def food_trucks_client
      FoodTrucks::DataSfAdapter.new
    end

    def search_address_coordinates
      @search_address_coordinates ||= Geocoder.search(address).first&.coordinates
    end

    def bounding_box
      Geocoder::Calculations.bounding_box(
        search_address_coordinates,
        radius_km
      )
    end
  end
end
