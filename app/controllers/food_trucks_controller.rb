# frozen_string_literal: true

class FoodTrucksController < ApplicationController
  before_action :check_radius_km

  def search
    search_service = FoodTrucks::SearchAroundAddressService.new(
      params[:address],
      params[:radius_km]
    )
    food_trucks = search_service.process
    render json: food_trucks, each_serializer: FoodTruckSerializer
  end

  private

  def check_radius_km
    return if params[:radius_km].blank?
    parsed_radius = Float(params[:radius_km])
    raise ApiErrors::BadRequestError.new(message: 'radius_km must be positive.') if parsed_radius <= 0
  rescue ArgumentError
    raise ApiErrors::BadRequestError.new(message: "Invalid format for radius_km: \"#{params[:radius_km]}\"")
  end
end
