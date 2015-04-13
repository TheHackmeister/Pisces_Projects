source 'https://rubygems.org'

gem 'haml-rails'
gem 'devise'
gem 'cancancan'
gem 'mysql2', "~>0.3.11"
gem 'sorted', '1.0.1'
gem 'ranked-model'
gem 'jquery-ui-rails'
gem 'kaminari'
#gem 'sunspot_rails', "~>2.1.0", :git => 'https://github.com/sunspot/sunspot.git'
#gem 'sunspot_solr', "~>2.1.0", :git => 'https://github.com/sunspot/sunspot.git'
gem 'sunspot_rails', github: "betam4x/sunspot" # , '2.1.1'
gem 'sunspot_solr', github: "betam4x/sunspot" # '2.1.1'
#gem 'progress_bar'
gem 'rsolr', "1.0.10"
gem 'coffee-script-source', '1.8.0'

group :test do
  gem 'faker'
  gem 'guard-rspec'
  gem 'launchy'
  gem 'cucumber-rails', :require => false
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'poltergeist'
  gem 'phantomjs', require: 'phantomjs/poltergeist'
  gem 'database_cleaner'
  gem "accept_values_for"
  gem 'formulaic'
end

group :development, :test do
  gem 'rspec-rails'
  gem "factory_girl_rails", "~> 4.5"
#  gem "factory_girl_rails", "~> 4.5", github: "thoughtbot/factory_girl_rails"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.5'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin]
