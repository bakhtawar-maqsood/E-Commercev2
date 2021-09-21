# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'
gem 'rails', '~> 5.2.6'
gem 'stripe', '~> 5.38'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'bootstrap',  '~>4.3.1'
gem 'pundit', '~> 1.1'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bullet', '~> 6.1', '>= 6.1.5'
gem 'mini_magick', '~> 4.8'
#gem 'paypal-sdk-rest', '~> 1.7', '>= 1.7.4'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'devise', '~> 4.8.0'
gem "bootstrap_form", "~> 4.0"
gem 'toastr-rails'
gem 'telephone_number'
gem 'dotenv-rails', :groups => [:development, :test]
gem 'mysql2',          '~> 0.5.0',    :platform => :ruby
gem 'thinking-sphinx', '~> 5.0'
gem 'pg_search'
gem 'jquery-rails'


group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  gem 'rubocop'
  gem 'rubocop-minitest'
  gem 'rubocop-performance'
  gem 'rubocop-rails', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]