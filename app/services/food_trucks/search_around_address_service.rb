# frozen_string_literal: true
module FoodTrucks
  class SearchAroundAddressService
    def initialize(address, radius_km)
      @address = address
      @radius_km = radius_km
    end

    def process
      food_trucks_client.food_trucks_within(bounding_box)
    end

    private

    attr_reader :address, :radius_km

    def food_trucks_client
      FoodTrucks::DataSfAdapter.new
    end

    def bounding_box
      Geocoder::Calculations.bounding_box(
        search_address_coordinates,
        radius_km
      )
    end

    def search_address_coordinates
      Geocoder.search(address).first.coordinates
    end
  end
end
