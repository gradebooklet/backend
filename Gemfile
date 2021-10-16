source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.4', '>= 6.1.4.1'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use Puma as the app server
gem 'puma', '~> 5.0'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

group :development, :test do
  # Use rspec for testing
  gem 'rspec-rails', '~> 5.0.0'

  # Use pry to debug ruby code
  gem 'pry-byebug'
end

group :development do
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  # Use factory bot to create fixtures
  gem 'factory_bot_rails'

  # Use faker for fake test data
  gem 'faker'

  # Use jsonapi-rspec for better test helpers
  gem 'jsonapi-rspec'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Devise is used to define permissions
gem 'devise'

# Use figaro to handle env
gem 'figaro'

# Use zxcvbn library to validate weak passwords
gem 'devise_zxcvbn'

# Use valid email to validate emails
gem "valid_email2"

# Use jsonapi to return valid json api objects
gem 'jsonapi-rails'

# Use api_guard to protect api
gem 'api_guard'

# Use rack_attack to prevent unnecessary requests
gem 'rack-attack'
