# frozen_string_literal: true

class FoodTrucksController < ApplicationController
  def search
    location = [123, 123]
    radius_km = 1

    res = food_trucks_client.food_trucks_around(location, radius_km)
    render json: { status: res.code, body: JSON.parse(res.body) }
  end

  private

  def food_trucks_client
    FoodTrucks::DataSfAdapter.new
  end
end
