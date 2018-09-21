# frozen_string_literal: true

class FoodTrucksController < ApplicationController
  def search
    search_service = FoodTrucks::SearchAroundAddressService.new(
      params[:address],
      params[:radius_km]
    )
    food_trucks = search_service.process
    render json: food_trucks, each_serializer: FoodTruckSerializer
  end
end
