Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "users/registrations", confirmations: 'users/confirmations', sessions: "users/sessions"}
  root to: 'home#index'
  get 'home/shop' => "home#shop", as: :shop
  get 'home/product' => "home#product", as: :product
  get 'home/cart' => "home#cart", as: :cart
  get 'home/contact' => "home#contact", as: :contact
  get 'home/blog' => "home#blog", as: :blog
  get 'home/blog_show' => "home#blog_show", as: :blog_show
  get 'home/add_favorite' => "home#add_favorite", as: :add_favorite
  get 'home/remove_favorite' => "home#remove_favorite", as: :remove_favorite
  get 'home/my_favorites' => "home#my_favorites", as: :my_favorites
  get 'home/add_to_cart' => "home#add_to_cart", as: :add_to_cart

  resources :dashboards
  get 'brands_list' => "dashboards#brands_list", as: :brands_list
  get 'add_brand' => "dashboards#add_brand", as: :add_brand
  post 'create_brand' => "dashboards#create_brand", as: :create_brand

  get 'catergory_list' => "dashboards#catergory_list", as: :catergory_list
  get 'add_catergory' => "dashboards#add_catergory", as: :add_catergory
  post 'create_catergory' => "dashboards#create_catergory", as: :create_catergory

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

  get 'product_color_list' => "dashboards#product_color_list", as: :product_color_list
  get 'add_product_color' => "dashboards#add_product_color", as: :add_product_color
  post 'create_product_color' => "dashboards#create_product_color", as: :create_product_color

  get 'product_size_list' => "dashboards#product_size_list", as: :product_size_list
  get 'add_product_size' => "dashboards#add_product_size", as: :add_product_size
  post 'create_product_size' => "dashboards#create_product_size", as: :create_product_size


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
