# frozen_string_literal: true

Rails.application.routes.draw do
  mount GoodJob::Engine => "good_job"

  resources :expenses, except: %i[show] do
    get :total_amount, on: :collection
  end

  resources :categories, only: %i[index destroy new create edit update] do
    resources :subcategories, only: %i[index]
  end

  resources :subcategories, only: [], param: :index do
    member do
      get "/new" => "subcategories#new"
      delete "(:id)" => "subcategories#delete", as: ""
    end
  end

  get "dashboard" => "dashboard#index"
  namespace :dashboard do
    resources :expenses, only: %i[index]
  end

  get "profile" => "profile#show"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "expenses#index"
end
