Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "users/registrations", confirmations: 'users/confirmations', sessions: "users/sessions"}
  root to: 'home#index'
  get 'home/shop' => "home#shop", as: :shop
  get 'home/sub_categories' => "home#sub_categories", as: :sub_categories
  get 'home/product_types' => "home#product_types", as: :product_types
  get 'home/product' => "home#product", as: :product
  get 'home/cart' => "home#cart", as: :cart
  get 'home/contact' => "home#contact", as: :contact
  get 'home/blog' => "home#blog", as: :blog
  get 'home/blog_show' => "home#blog_show", as: :blog_show
  get 'home/checkout' => "home#checkout", as: :checkout
  get 'home/add_favorite' => "home#add_favorite", as: :add_favorite
  get 'home/remove_favorite' => "home#remove_favorite", as: :remove_favorite
  get 'home/my_favorites' => "home#my_favorites", as: :my_favorites
  get 'home/add_to_cart' => "home#add_to_cart", as: :add_to_cart
  post 'home/create_shipping' => "home#create_shipping", as: :create_shipping
  get 'home/product_detail_modal' => "home#product_detail_modal", as: :product_detail_modal
  post 'home/add_card' => "home#add_card", as: :add_card


  resources :dashboards
  get 'brands_list' => "dashboards#brands_list", as: :brands_list
  get 'add_brand' => "dashboards#add_brand", as: :add_brand
  post 'create_brand' => "dashboards#create_brand", as: :create_brand

  get 'catergory_list' => "dashboards#catergory_list", as: :catergory_list
  get 'add_catergory' => "dashboards#add_catergory", as: :add_catergory
  post 'create_catergory' => "dashboards#create_catergory", as: :create_catergory
  get 'edit_category' => "dashboards#edit_category", as: :edit_category
  put 'update_category' => "dashboards#update_category", as: :update_category

  get 'sub_category_list' => "dashboards#sub_category_list", as: :sub_category_list
  get 'add_sub_category' => "dashboards#add_sub_category", as: :add_sub_category
  post 'create_sub_category' => "dashboards#create_sub_category", as: :create_sub_category

  get 'product_type_list' => "dashboards#product_type_list", as: :product_type_list
  get 'add_product_type' => "dashboards#add_product_type", as: :add_product_type
  post 'create_product_type' => "dashboards#create_product_type", as: :create_product_type

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

  resources :conversations
  resources :personal_messages
  resources :users, only: [:index]
  mount ActionCable.server => '/cable'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
