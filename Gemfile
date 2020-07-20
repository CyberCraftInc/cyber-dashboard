source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'activerecord-session_store'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'devise', '4.7.1'
gem 'foreman', '0.87.1'
gem 'jbuilder', '~> 2.10'
gem 'omniauth-google-oauth2', '0.8.0'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.3'
gem 'pundit', '2.1.0'
gem 'rails', '~> 6.0.3'
gem 'rails_admin', '~> 2.0', git: 'https://github.com/sferik/rails_admin.git'
gem 'sass-rails', '~> 6.0'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker', '5.1.1'

group :development, :test do
  gem 'factory_bot_rails', '5.2.0'
  gem 'letter_opener', '1.7.0'
  gem 'overcommit', '~> 0.55.0'
  gem 'pry-rails', '~> 0.3.8'
  gem 'rspec-rails', '4.0.1'
  gem 'rubocop', '~> 0.86.0', require: false
  gem 'rubocop-rails', '~> 2.6.0', require: false
  gem 'rubocop-rspec', '~> 1.39.0', require: false
  gem 'simplecov', '0.18.5', require: false
end

group :test do
  gem 'capybara', '3.32.2'
  gem 'database_cleaner'
  gem 'guard-rspec', '4.7.3'
  gem 'launchy', '2.5.0'
  gem 'selenium-webdriver', '3.142.7'
end

gem 'haml', '5.1.2'
gem 'haml-rails', '2.0.1'
gem 'travis'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
