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

    get    :'/variants',        to: 'variants#index',  as: :variants
    # get    :'/new/variant/:id',   to: 'variants#new',   as: :new_variant
    # post   :'/create/variant/:id',   to: 'variants#create',   as: :create_variant
    # get    :'/edit/variant/:id',   to: 'variants#edit',   as: :edit_variant,   constraints: { id: /[0-9]+/ }
    # post   :'/update/variant/:id',   to: 'variants#update',   as: :update_variant,   constraints: { id: /[0-9]+/ }
    # delete :'/destroy/variant/:id', to: 'variants#destroy', as: :destroy_variant, constraints: { id: /[0-9]+/ }

    get    :'/products',        to: 'products#index',  as: :products
    # get    :'/new/product/:id',   to: 'products#new',   as: :new_product
    # post   :'/create/product/:id',   to: 'products#create',   as: :create_product
    # get    :'/edit/product/:id',   to: 'products#edit',   as: :edit_product,   constraints: { id: /[0-9]+/ }
    # post   :'/update/product/:id',   to: 'products#update',   as: :update_product,   constraints: { id: /[0-9]+/ }
    # delete :'/destroy/product/:id', to: 'products#destroy', as: :destroy_product, constraints: { id: /[0-9]+/ }

    get    :'/option_types',        to: 'option_types#index',  as: :option_types
    # get    :'/new/option_type/:id',   to: 'option_types#new',   as: :new_option_type
    # post   :'/create/option_type/:id',   to: 'option_types#create',   as: :create_option_type
    # get    :'/edit/option_type/:id',   to: 'option_types#edit',   as: :edit_option_type,   constraints: { id: /[0-9]+/ }
    # post   :'/update/option_type/:id',   to: 'option_types#update',   as: :update_option_type,   constraints: { id: /[0-9]+/ }
    # delete :'/destroy/option_type/:id', to: 'option_types#destroy', as: :destroy_option_type, constraints: { id: /[0-9]+/ }
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
