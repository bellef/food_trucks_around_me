# frozen_string_literal: true

class FoodTrucksController < ApplicationController
  before_action :check_params

  def search
    search_service = FoodTrucks::SearchAroundAddressService.new(
      params[:address],
      params[:radius_km]
    )
    food_trucks = search_service.process
    render json: food_trucks, each_serializer: FoodTruckSerializer
  end

  private

  def check_params
    parsed_radius = Float(params[:radius_km])
    raise ApiErrors::BadRequestError.new(message: 'Radius cannot be negative, please provide a positive radius.') if parsed_radius.negative?
  rescue ArgumentError
    raise ApiErrors::BadRequestError.new(message: "Invalid format for radius_km: \"#{params[:radius_km]}\"")
  end
end
