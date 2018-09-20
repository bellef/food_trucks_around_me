Rails.application.routes.draw do
  resources :food_trucks
  root 'food_trucks#search'
end
