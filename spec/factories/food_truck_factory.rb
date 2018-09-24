# frozen_string_literal: true

FactoryBot.define do
  factory :food_truck do
    latitude { 37.7592402851502 }
    longitude { -122.418544171117 }
    address { '2365 MISSION ST' }
    name { "Julie's Hot Dogs" }
    food_items { 'Hot dogs: Bacon wrapped hot dogs: soda: water: sports drinks: energy drinks: chips' }
    location_description { 'MISSION ST: 19TH ST to 20TH ST (2300 - 2399)' }
    schedule { 'Tu/We/Th:12AM-3AM;Mo-We:12PM-12AM' }
    schedule_url { 'https://some.url.pdf' }
  end
end
