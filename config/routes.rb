# == Route Map
#

Rails.application.routes.draw do
  devise_for :users
  resources :books do
    resources :reviews, only: [:create, :edit, :update, :destroy]
  end

  root to: "home#index"
end
