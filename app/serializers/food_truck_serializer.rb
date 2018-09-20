class FoodTruckSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :location_description, :latitude, :longitude, :food_items, :schedule, :schedule_url
end
