source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.4'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'devise'
gem 'importmap-rails'
gem 'nodo'
gem 'pg', '~> 1.1'
gem 'puma'
gem 'rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails'
  gem 'rubocop'

  gem 'html2haml'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

gem 'haml-rails'
gem 'sprockets-rails'
gem 'tailwindcss-rails', '~> 2.1'
