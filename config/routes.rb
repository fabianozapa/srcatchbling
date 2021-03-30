Rails.application.routes.draw do

  devise_for :users

  devise_scope :user do
    root to: 'devise/sessions#new'
    get :'/users/sign_out2', to: 'devise/sessions#destroy', as: :destroy_user_session_2
  end

  namespace :admin do
    get    :'/users',           to: 'users#index',  as: :users
    get    :'/edit/user/:id',   to: 'users#edit',   as: :edit_user,   constraints: { id: /[0-9]+/ }
    patch  :'/update/user/:id', to: 'users#update', as: :update_user, constraints: { id: /[0-9]+/ }
  end

  namespace :api do
    namespace :v1 do
      get :'/:product_slug', to: 'variants#index', as: :variants, constraints: { product_slug: /[0-9A-z\-\_]+/ }
      post :'/:product_slug', to: 'variants#create', as: :variant_create, constraints: { product_slug: /[0-9A-z\-\_]+/ }
      put :'/:product_slug/:id', to: 'variants#update', as: :variant_update, constraints: { product_slug: /[0-9A-z\-\_]+/, id: /[0-9]+/ }
      delete :'/:product_slug/:id', to: 'variants#destroy', as: :variant_destroy, constraints: { product_slug: /[0-9A-z\-\_]+/, id: /[0-9]+/ }
    end
  end

end
