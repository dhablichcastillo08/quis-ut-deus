require "sidekiq/web"

Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  authenticated :user do
    root "dashboard#index", as: :authenticated_root
    mount Sidekiq::Web => "/sidekiq"
  end

  devise_scope :user do
    root "devise/sessions#new"
  end

  get "dashboard", to: "dashboard#index"

  get "readings/today", to: "readings#show", defaults: { date: "today" }, as: :readings_today
  resources :readings, only: [:show], param: :date

  resources :prayer_habits, only: [:index, :new, :create, :destroy] do
    resources :prayer_logs, only: [:create] do
      collection do
        delete :today
      end
    end
  end
end
