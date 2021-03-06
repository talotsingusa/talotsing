Rails.application.routes.draw do
  namespace :dashboard do
    resources :brands, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :product_types, only: [:index, :new, :create]
    resources :users, only: [:index]
    resources :conversations, only: [:index, :new, :show]
    resources :personal_messages, only: [:new, :create]
    resources :orders, only: [] do
      collection do
        get :unpaid_orders
        get :paid_orders
        get :shipped_orders
      end
      member do
        get :ship_order
      end
    end
  end
  resources :shopping_carts, except: [:new, :create, :edit, :update, :destroy, :index, :show] do
    collection do
      get 'checkout'
      post 'process_payment'
      get 'remove_items_from_cart'
    end
  end
  resources :conversations
  resources :personal_messages

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks", passwords: 'users/passwords' }
  root to: 'home#index'
  get 'home/shop' => "home#shop", as: :shop
  get 'home/sub_categories' => "home#sub_categories", as: :sub_categories
  get 'home/product_types' => "home#product_types", as: :product_types
  get 'home/product' => "home#product", as: :product
  get 'home/cart' => "home#cart", as: :cart
  get 'home/contact' => "home#contact", as: :contact
  get 'home/blog' => "home#blog", as: :blog
  get 'home/blog_show' => "home#blog_show", as: :blog_show
  get 'home/add_favorite' => "home#add_favorite", as: :add_favorite
  get 'home/remove_favorite' => "home#remove_favorite", as: :remove_favorite
  get 'home/my_favorites' => "home#my_favorites", as: :my_favorites
  get 'home/add_to_cart' => "home#add_to_cart", as: :add_to_cart
  post 'home/create_shipping' => "home#create_shipping", as: :create_shipping
  get 'home/product_detail_modal' => "home#product_detail_modal", as: :product_detail_modal
  get 'home/about_us' => "home#about_us", as: :about_us
  get 'home/contact_us' => "home#contact_us", as: :contact_us
  get 'home/terms_of_use' => "home#terms_of_use", as: :terms_of_use
  get 'home/discount_policy' => "home#discount_policy", as: :discount_policy
  get 'home/return' => "home#return", as: :return
  get 'home/privacy_policy' => "home#privacy_policy", as: :privacy_policy
  get 'home/shipping_help' => "home#shipping_help", as: :shipping_help
  get 'home/see_all' => 'home#see_all'
  resources :dashboards do
    collection do
      get :order_shipping_details
    end
  end

  get 'catergory_list' => "dashboards#catergory_list", as: :catergory_list
  get 'add_catergory' => "dashboards#add_catergory", as: :add_catergory
  post 'create_catergory' => "dashboards#create_catergory", as: :create_catergory
  get 'edit_category' => "dashboards#edit_category", as: :edit_category
  put 'update_category' => "dashboards#update_category", as: :update_category

  get 'sub_category_list' => "dashboards#sub_category_list", as: :sub_category_list
  get 'add_sub_category' => "dashboards#add_sub_category", as: :add_sub_category
  post 'create_sub_category' => "dashboards#create_sub_category", as: :create_sub_category

  get 'store' => "dashboards#store", as: :store
  get 'add_store' => "dashboards#add_store", as: :add_store
  post 'create_store' => "dashboards#create_store", as: :create_store

  get 'product_list' => "dashboards#product_list", as: :product_list
  get 'add_product' => "dashboards#add_product", as: :add_product
  post 'create_product' => "dashboards#create_product", as: :create_product
  get 'edit_product' => "dashboards#edit_product", as: :edit_product
  put 'update_product' => "dashboards#update_product", as: :update_product
  get 'delete_product' => "dashboards#delete_product", as: :delete_product

  get 'product_color_list' => "dashboards#product_color_list", as: :product_color_list
  get 'add_product_color' => "dashboards#add_product_color", as: :add_product_color
  post 'create_product_color' => "dashboards#create_product_color", as: :create_product_color

  get 'product_size_list' => "dashboards#product_size_list", as: :product_size_list
  get 'add_product_size' => "dashboards#add_product_size", as: :add_product_size
  post 'create_product_size' => "dashboards#create_product_size", as: :create_product_size

  get 'closure_type_list' => "dashboards#closure_type_list", as: :closure_type_list
  get 'add_closure_type' => "dashboards#add_closure_type", as: :add_closure_type
  post 'create_closure_type' => "dashboards#create_closure_type", as: :create_closure_type


  get 'collar_list' => "dashboards#collar_list", as: :collar_list
  get 'add_collar_type' => "dashboards#add_collar_type", as: :add_collar_type
  post 'create_collar_type' => "dashboards#create_collar_type", as: :create_collar_type

  get 'craft_list' => "dashboards#craft_list", as: :craft_list
  get 'add_craft_type' => "dashboards#add_craft_type", as: :add_craft_type
  post 'create_craft_type' => "dashboards#create_craft_type", as: :create_craft_type


  get 'design_list' => "dashboards#design_list", as: :design_list
  get 'add_design' => "dashboards#add_design", as: :add_design
  post 'create_design' => "dashboards#create_design", as: :create_design

  get 'design_type_list' => "dashboards#design_type_list", as: :design_type_list
  get 'add_design_type' => "dashboards#add_design_type", as: :add_design_type
  post 'create_design_type' => "dashboards#create_design_type", as: :create_design_type

  get 'pattern_style_list' => "dashboards#pattern_style_list", as: :pattern_style_list
  get 'add_pattern_style' => "dashboards#add_pattern_style", as: :add_pattern_style
  post 'create_pattern_style' => "dashboards#create_pattern_style", as: :create_pattern_style


  get 'sleeve_type_list' => "dashboards#sleeve_type_list", as: :sleeve_type_list
  get 'add_sleeve_type' => "dashboards#add_sleeve_type", as: :add_sleeve_type
  post 'create_sleeve_type' => "dashboards#create_sleeve_type", as: :create_sleeve_type


  get 'styles_list' => "dashboards#styles_list", as: :styles_list
  get 'add_style' => "dashboards#add_style", as: :add_style
  post 'create_style' => "dashboards#create_style", as: :create_style

  get 'shipping_prices' => "dashboards#shipping_prices", as: :shipping_prices
  get 'add_shipping_prices' => "dashboards#add_shipping_prices", as: :add_shipping_prices
  post 'create_shipping_price' => "dashboards#create_shipping_price", as: :create_shipping_price

  get 'orders_list' => "dashboards#orders_list", as: :orders_list
  get 'pending_orders' => "dashboards#pending_orders", as: :pending_orders
  get 'completed_orders' => "dashboards#completed_orders", as: :completed_orders
  get 'order_details' => "dashboards#order_details", as: :order_details
  get 'my_order_details' => "dashboards#my_order_details", as: :my_order_details
  get 'change_product_status' => "dashboards#change_product_status", as: :change_product_status
  get 'change_order_status' => "dashboards#change_order_status", as: :change_order_status
  mount ActionCable.server => '/cable'

  #For static pages
  get "/pages/:page" => "pages#show"
  resources :states, only: :index
end
