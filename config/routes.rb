Rails.application.routes.draw do

  get 'ingredients/index'
  get 'providers/index' 
  get 'providers/new', to: "providers#new"
  post 'providers', to: "providers#create"

  scope path: '/api' do
    api_version(module: 'Api::V1', path: { value: 'v1' }, defaults: { format: 'json' }) do
    end
  end
  mount Rswag::Api::Engine => '/api-docs'
  mount Rswag::Ui::Engine => '/api-docs'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  mount Sidekiq::Web => '/queue'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
