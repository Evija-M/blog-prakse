# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get '/users/sign_out' => 'users/sessions#destroy'
    get 'users/destroy' => 'users/registrations#destroy'
    resources :users
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  scope '(:locale)' do
    resources :articles do
      resources :comments
      get 'showarchived', to: 'articles#showarchived', on: :collection
      get 'export', to: 'articles#export', on: :collection
    end
    resources :users do
      resources :articles
      get 'articles', to: 'articles#show_user_articles', on: :collection
    end
  end
  # Defines the root path route ("/")
  root 'articles#index'
end
