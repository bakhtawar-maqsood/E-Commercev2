# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resource :guest_carts, only: %i[create show update]
  resource :wishlist, only: %i[create show destroy]

  resources :users do
    resources :products, shallow: true do
      resources :comments, except: %i[show new index]
    end
    resource :order, except: %i[index edit new] do
      get :order_history, on: :member, as: :history
      resources :order_items, only: [:update], shallow: true
    end
  end

  root 'home#all_products'
end
