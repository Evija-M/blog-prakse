# frozen_string_literal: true

require 'resque/server'
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
      get 'restore', to: 'articles#restore_article'
      get 'delete', to: 'articles#delete_article'
    end
    resources :users do
      get 'deleted_comments/:user_id', to: 'comments#show_user_deleted_comments', on: :collection, as: 'deleted_comments'
      resources :articles
      get 'articles', to: 'articles#show_user_articles', on: :collection
      get 'deleted_articles', to: 'articles#show_user_deleted_articles', on: :collection
    end
    get 'users/restore/:user_id', to: 'users#restore_user', as: 'users_restore'
    get 'users/restore_comment/:comment_id', to: 'comments#restore_comment', as: 'comment_restore'
    get 'users/delete_comment/:comment_id', to: 'comments#delete_comment', as: 'delete_comment'
  end
  # Defines the root path route ("/")
  root 'articles#index'

  mount Resque::Server.new, at: '/resque'
  get '/' => 'articles#index'
end
