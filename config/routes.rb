# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :controllers
  devise_for :users

  resource :guest_carts, only: [:create, :show, :update]
  #post 'add_guest_cart', to:'guest_carts#add', as: :cart

  resources :users do
    resources :products, shallow: true do
      resources :comments
    end
    resource :wishlist
    resource :order do
      get :order_history, on: :member, as: :history
      resources :charges, only: [:new, :create]
      resources :order_items, only: [:update], shallow: true
    end
  end


  root 'home#all_products'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
