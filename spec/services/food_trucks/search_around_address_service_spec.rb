# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FoodTrucks::SearchAroundAddressService do
  describe '#process' do
    let(:address) { '2675 Folsom Street, San Francisco' }
    let(:bounding_box) { [12.3, -30.4, 13.2, -31.2] }
    let(:raw_items) do
      raw_file = File.read(Rails.root.join('spec/mocks/data_sf/get_success_body.json'))
      JSON.parse(raw_file)
    end

    before do
      allow_any_instance_of(FoodTrucks::DataSfAdapter).to(
        receive(:food_trucks_within) { raw_items }
      )

      allow_any_instance_of(described_class).to(
        receive(:bounding_box) { bounding_box }
      )
    end

    subject { described_class.new(address).process }

    it 'calls the Adapter#food_trucks_within method' do
      expect_any_instance_of(FoodTrucks::DataSfAdapter).to(
        receive(:food_trucks_within).with(bounding_box)
      )
      subject
    end

    it 'calls the Deserializer.deserialize_collection method' do
      expect(FoodTrucks::Deserializers::DataSfDeserializer).to(
        receive(:deserialize_collection).with(raw_items)
      )
      subject
    end
  end
end
