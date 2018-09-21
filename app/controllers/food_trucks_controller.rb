# frozen_string_literal: true

class FoodTrucksController < ApplicationController
  def search
    res = food_trucks_client.food_trucks_within(bounding_box)
    render json: { status: res.code, body: JSON.parse(res.body) }
  end

  private

  # TODO extract in a service object
  def bounding_box
    Geocoder::Calculations.bounding_box(
      search_address_coordinates,
      params[:radius_km]
    )
  end

  # TODO extract in a service object
  def search_address_coordinates
    Geocoder.search(params[:address]).first.coordinates
  end

  def food_trucks_client
    FoodTrucks::DataSfAdapter.new
  end
end
