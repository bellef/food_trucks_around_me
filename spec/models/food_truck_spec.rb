# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FoodTruck, type: :model do
  describe '.new' do
    let(:food_truck) { build(:food_truck) }
    subject { food_truck }

    context 'with valid attributes' do
      it { is_expected.to be_valid }
    end

    describe 'validations' do
      let(:food_truck) { build(:food_truck, options) }
      before(:each) { subject.validate }

      context 'when attributes are missing' do
        let(:options) do
          {
            address: nil,
            latitude: nil,
            longitude: nil,
            name: nil
          }
        end

        it { is_expected.to be_invalid }
        it 'contains errors' do
          expect(subject.errors.messages.keys).to(
            include(:address, :latitude, :longitude, :name)
          )
        end
      end

      context 'when latitude and longitude are not numbers' do
        let(:options) do
          {
            latitude: 'NaN',
            longitude: 'NaN'
          }
        end

        it { is_expected.to be_invalid }
        it 'contains errors' do
          expect(subject.errors.messages.keys).to(
            include(:latitude, :longitude)
          )
        end
      end
    end
  end
end
