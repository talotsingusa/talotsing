source 'https://rubygems.org'
ruby "2.4.0"
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.5'
# Use sqlite3 as the database for Active Record

gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
# gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

#Styling gems
gem 'bootstrap', '~> 4.1.1'
gem 'jquery-rails'
gem 'popper_js'
gem 'jquery-easing-rails'
gem "font-awesome-rails"
gem 'font-awesome-sass', '~> 5.0.13'
gem 'greensock-rails'
gem 'isotope-rails'
gem 'jquery-ui-rails'
gem 'simple_form'
gem 'toastr-rails'
gem 'owlcarousel2'
gem 'parallax-rails'
gem 'parallaximage-rails'
gem 'modernizr-rails'
gem 'kaminari'
gem 'bootstrap4-kaminari-views'
# gem 'scrollmagicjs-rails'
gem 'jquery-slick-rails'
gem 'jquery-sliders-rails'
gem "select2-rails"

#Authentication
gem 'devise'

gem 'pry'
#Handle images in project
gem 'paperclip', '~> 5.2.0'
gem 'paperclip-ffmpeg'
gem 'paperclip-av-transcoder'
gem 'aws-sdk',   '~> 2.6'
gem 'jquery-datatables'
gem 'chosen-rails'
gem "selectize-rails"
gem 'slick_rails'
gem "cocoon"
gem 'dotenv-rails', groups: [:development, :test]

gem 'intl-tel-input-rails'
gem 'will_paginate-bootstrap4'
gem 'geocomplete_rails'
gem 'redis'
gem 'puma_worker_killer'
gem 'elevatezoom-rails', '~> 1.0'
#gem for social media login
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'activerecord-session_store'

#Gem for payments
gem 'square_connect'

#For nice data-base view in console
gem 'hirb'

#For permissions
gem 'cancancan'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'sqlite3'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'bullet'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
