# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FoodTrucks::Deserializers::DataSfDeserializer do
  let(:raw_items) do
    raw_file = File.read(Rails.root.join('spec/mocks/data_sf/get_success_body.json'))
    JSON.parse(raw_file)
  end

  describe '.deserialize' do
    let(:raw_item) { raw_items.first }
    subject { described_class.deserialize(raw_item) }

    it { is_expected.to be_a(FoodTruck) }

    context 'with invalid data' do
      let(:raw_item) { raw_items.first.except("Address") }

      it 'raises an error' do
        expect { subject }.to raise_error(ActiveModel::ValidationError)
      end
    end
  end

  describe '.deserialize_collection' do
    let(:raw_item) { raw_items }
    subject { described_class.deserialize_collection(raw_items) }

    it { is_expected.to be_a(Array) }
    it 'should be an array of FoodTruck objects' do
      expect(subject.first).to be_a(FoodTruck)
    end
  end
end
