source 'https://rubygems.org'

ruby '2.0.0'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use sqlite3 as the database for Active Record
gem 'sqlite3'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

# Faker, a port of Data::Faker from Perl, is used to easily generate 
# fake data: names, addresses, phone numbers, etc.
gem "faker", "~> 1.2.0"

# Twitter's Bootstrap, converted to Sass and ready to drop into Rails or Compass
gem "bootstrap-sass", "~> 2.3.2.1"

# will_paginate provides a simple API for performing paginated queries with 
# Active Record, DataMapper and Sequel, and includes helpers for rendering 
# pagination links in Rails, Sinatra and Merb web apps.
gem "will_paginate", "~> 3.0.4"

# Hooks into will_paginate to format the html to match Twitter Bootstrap styling.
gem "bootstrap-will_paginate", "~> 0.0.9"

# Using the multi-threaded puma app server
gem 'puma'

# Using Haml preprocessor
gem 'haml-rails'

group :test, :development do
  gem 'rspec-rails'
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'spork'
  gem 'childprocess'

end

group :test do
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  # gem 'launchy', '2.1.0'
  # gem 'rb-fsevent', '0.9.1', :require => false
  # gem 'growl', '1.0.3'
end

group :production do
  gem "pg", "~> 0.16.0"
end
# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
