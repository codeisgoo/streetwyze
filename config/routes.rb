# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }

  root 'assers#index'
  # resources :assers
  # resources :stores
  resources :assers do
    resources :stories, only: [:new, :create]
  end
  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
