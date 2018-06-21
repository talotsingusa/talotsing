Rails.application.routes.draw do
  root to: 'home#index'
  get 'home/shop' => "home#shop", as: :shop
  get 'home/product' => "home#product", as: :product
  get 'home/cart' => "home#cart", as: :cart
  get 'home/contact' => "home#contact", as: :contact
  get 'home/blog' => "home#blog", as: :blog
  get 'home/blog_show' => "home#blog_show", as: :blog_show
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
