# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users
  resources :comments, only: :create

  resources :projects do
    member do
      patch :state, to: 'project_states#update', as: :project_state
    end
  end
end
