# frozen_string_literal: true

class FoodTruck
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :latitude,
                :longitude,
                :address,
                :name,
                :food_items,
                :location_description,
                :schedule_short,
                :schedule_url

  validates :latitude, :longitude, :address, :name, presence: true
  validates :latitude, :longitude, numericality: true

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
end
