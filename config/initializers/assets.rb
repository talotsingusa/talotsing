# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')
Rails.application.config.assets.precompile += %w( shop_application.css )
Rails.application.config.assets.precompile += %w( shop_application.js )
Rails.application.config.assets.precompile += %w( product_application.css )
Rails.application.config.assets.precompile += %w( product_application.js )
Rails.application.config.assets.precompile += %w( cart_application.css )
Rails.application.config.assets.precompile += %w( cart_application.js )
Rails.application.config.assets.precompile += %w( contact_application.css )
Rails.application.config.assets.precompile += %w( contact_application.js )
Rails.application.config.assets.precompile += %w( blog_application.css )
Rails.application.config.assets.precompile += %w( blog_application.js )
Rails.application.config.assets.precompile += %w( blog_single_application.css )
Rails.application.config.assets.precompile += %w( blog_single_application.js )
Rails.application.config.assets.precompile += %w( plain_application.css )
Rails.application.config.assets.precompile += %w( plain_application.js )
Rails.application.config.assets.precompile += %w( dashboard_application.css )
Rails.application.config.assets.precompile += %w( dashboard_application.js )
Rails.application.config.assets.precompile += %w( .js .css *.css.scss .svg .eot .woff .ttf)

# Precompile additional assets.
# application.js, application.css.scss, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
