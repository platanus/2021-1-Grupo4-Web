Rails.application.routes.draw do
  root to: 'home#index'
  scope path: '/api' do
    api_version(module: 'Api::V1', path: { value: 'v1' }, defaults: { format: 'json' }) do
      resources :ingredients
      resources :providers
      resources :menus do
        resources :menu_recipes, only: [:create, :update, :destroy]
        member do
          post '/reduce-inventory', to: 'menus#reduce_inventory'
        end
      end
      resources :recipes do
        resources :recipe_ingredients, only: [:create, :update, :destroy]
        resources :recipe_steps, only: [:create, :update, :destroy]
      end

      namespace :users do
        devise_scope :user do
          resources :registrations, only: [:create]
          resources :sessions, only: [:create]
        end
      end

      # Ingredients by scraper
      get '/search-jumbo-products', to: 'ingredients#search_jumbo_products'
      get '/search-lider-products', to: 'ingredients#search_lider_products'
      get '/search-cornershop-products', to: 'ingredients#search_cornershop_products'
    end
  end

  mount Rswag::Api::Engine => '/api-docs'
  mount Rswag::Ui::Engine => '/api-docs'

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount Sidekiq::Web => '/queue'

  resources :ingredients, only: [:index]
  resources :recipes, only: [:index, :show, :new, :edit]
  resources :menus, only: [:index, :new]
  resources :providers, only: [:index, :new]
end
