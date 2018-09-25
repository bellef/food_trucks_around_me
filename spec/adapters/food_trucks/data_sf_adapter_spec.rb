# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FoodTrucks::DataSfAdapter do
  subject { described_class.new }

  describe '#food_trucks_within' do
    let(:bounding_box) { [12.3, -30.4, 13.2, -31.2] }

    it 'responds with an HTTParty::Response object' do
      expect(subject.food_trucks_within(bounding_box)).to be_a(HTTParty::Response)
    end

    context 'when response is not successful' do
      before do
        allow_any_instance_of(HTTParty::Response).to receive(:success?) { false }
      end

      it 'raises an error' do
        expect { subject.food_trucks_within(bounding_box) }.to raise_error(CustomErrors::Api::ThirdPartyApiError)
      end
    end
  end
end
