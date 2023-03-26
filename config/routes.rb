# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users

  resources :projects do
    member do
      resources :comments, only: :create
      patch :state, to: 'project_states#update', as: :project_state
    end
  end
end
