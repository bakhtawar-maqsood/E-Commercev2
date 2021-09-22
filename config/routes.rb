# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :controllers
  devise_for :users

  resource :guest_carts, only: [:create, :show]

  resources :users do
    resources :products, shallow: true do
      resources :comments, except: [:show, :new, :index]
    end
    resource :wishlist, only: [:create, :show, :destroy]
    resource :order, except: [:index, :edit, :new] do
      get :order_history, on: :member, as: :history
      resources :order_items, only: [:update], shallow: true
    end
  end

  root 'home#all_products'
end
