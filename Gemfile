source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }


gem 'rails', '~> 6.1.3', '>= 6.1.3.2'

# Basics
gem 'bootsnap', '>= 1.4.4', require: false
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'

# Auth
#gem 'devise_token_auth', '~> 1.1.4'
gem 'devise_token_auth', github: 'lynndylanhurley/devise_token_auth', branch: 'master'

# Cors
gem 'rack-cors', '1.1.1'

# Render
gem 'jbuilder', '~> 2.10.1'

# Task
gem 'tty-spinner'

#Search
gem "searchkick"
gem 'elasticsearch', '~> 7.14', '>= 7.14.1'
group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails', '~> 4.0.1'
  gem 'shoulda-matchers', '~> 4.0'
  gem 'cpf_faker', '~> 1.0'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'rails_best_practices', '~> 1.23', '>= 1.23.2', require: false
  gem 'spring'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
