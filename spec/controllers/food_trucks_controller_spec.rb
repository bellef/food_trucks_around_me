# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FoodTrucksController, type: :controller do
  let(:address) { '2675 Folsom Street, San Francisco' }
  let(:radius_km) { 0.2 }
  let(:food_trucks) { [build(:food_truck)] }

  before do
    allow_any_instance_of(FoodTrucks::SearchAroundAddressService).to(
      receive(:process) { food_trucks }
    )
  end

  it 'has a 200 status code' do
    get :search, params: { address: address, radius_km: radius_km }
    expect(response.status).to eq(200)
    expect(response).to match_response_schema('food_trucks')
  end

  context 'when the address is missing' do
    it 'has a 400 status code' do
      get :search, params: { radius_km: radius_km }
      expect(response.status).to eq(400)
    end
  end

  context 'when the radius_km is negative' do
    it 'has a 400 status code' do
      get :search, params: { address: address, radius_km: -0.1 }
      expect(response.status).to eq(400)
    end
  end

  context 'when the radius_km is invalid' do
    it 'has a 400 status code' do
      get :search, params: { address: address, radius_km: 'abcd' }
      expect(response.status).to eq(400)
    end
  end
end
