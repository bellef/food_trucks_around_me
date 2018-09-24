# frozen_string_literal: true

require 'rails_helper'

describe FoodTruckSerializer do
  let(:food_truck) { build(:food_truck) }
  subject(:serialized_food_truck) { described_class.new(food_truck) }

  it 'serializes an object' do
    expect(serialized_food_truck.attributes).to(
      eq(
        name: food_truck.name,
        address: food_truck.address,
        location_description: food_truck.location_description,
        latitude: food_truck.latitude,
        longitude: food_truck.longitude,
        food_items: food_truck.food_items,
        schedule: food_truck.schedule,
        schedule_url: food_truck.schedule_url
      )
    )
  end
end
