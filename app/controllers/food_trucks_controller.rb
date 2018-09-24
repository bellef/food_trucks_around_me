# frozen_string_literal: true

class FoodTrucksController < ApplicationController
  before_action :check_radius_km
  before_action :check_address

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
    raise CustomErrors::Api::BadRequestError.new(message: 'radius_km must be positive.') if parsed_radius <= 0
  rescue ArgumentError
    raise CustomErrors::Api::BadRequestError.new(message: "Invalid format for radius_km: \"#{params[:radius_km]}\"")
  end

  def check_address
    raise CustomErrors::Api::BadRequestError.new(message: 'address missing, please provide an address query parameter.') if params[:address].blank?
  end
end
