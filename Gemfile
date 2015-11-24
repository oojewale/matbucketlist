source "https://rubygems.org"

gem "rails", "4.2.4"
gem "rails-api"
gem "pg", "0.17.1"
gem "figaro"
gem "jwt"
gem "bcrypt", "~> 3.1.7"
gem "active_model_serializers", "~> 0.8.0"

group :development do
  gem "spring"
end

group :development, :test do
  gem "rspec-rails", "~> 3.0"
  gem "pry"
  gem "codeclimate-test-reporter", require: nil
end

group :production do
  ruby "2.2.3"
  gem "rails_12factor", "0.0.2"
end