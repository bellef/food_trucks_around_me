# frozen_string_literal: true

class FoodTrucksController < ApplicationController
  def search
    search_service = FoodTrucks::SearchAroundAddressService.new(
      params[:address],
      params[:radius_km]
    )
    results = search_service.process
    render json: { status: results.code, body: JSON.parse(results.body) }
  end
end
