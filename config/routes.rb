Rails.application.routes.draw do
  scope path: '/api' do
    api_version(module: 'Api::V1', path: { value: 'v1' }, defaults: { format: 'json' }) do
      namespace :users do
        devise_scope :user do
          resources :registrations, only: [:create]
          resources :sessions, only: [:create]
        end
      end
    end
  end

  mount Rswag::Api::Engine => '/api-docs'
  mount Rswag::Ui::Engine => '/api-docs'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  mount Sidekiq::Web => '/queue'
  get '/test' => 'test#test'
  get '/ingredients' => 'ingredient#index' 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end