# frozen_string_literal: true

source 'https://rubygems.org'

gem 'onlyoffice_digitalocean_wrapper', git: 'https://github.com/onlyoffice-testing-robot/onlyoffice_digitalocean_wrapper'
gem 'onlyoffice_documentserver_testing_framework', git: 'https://github.com/onlyoffice-testing-robot/onlyoffice_documentserver_testing_framework'

group :development do
  gem 'overcommit'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
end
