# frozen_string_literal: true

source 'https://rubygems.org'

gem 'onlyoffice_webdriver_wrapper', git: 'https://github.com/onlyoffice-testing-robot/onlyoffice_webdriver_wrapper'

group :development do
  gem 'overcommit'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
end
