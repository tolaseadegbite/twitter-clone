source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

gem "bootsnap", require: false
gem "cssbundling-rails"
gem "delayed_job_active_record"
gem "devise", github: "heartcombo/devise", branch: "main"
gem "image_processing", "~> 1.2"
gem "importmap-rails"
gem "jbuilder"
gem "jsbundling-rails"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "rails", "~> 7.0.4", ">= 7.0.4.2"
gem "redis", "~> 4.0"
gem "sassc-rails"
gem "sprockets-rails"
gem "stimulus-rails"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "factory_bot_rails"
  gem 'faker', :git => 'https://github.com/faker-ruby/faker.git', :branch => 'main'
  gem "pry-rails"
  gem "rspec-rails", "~> 6.0.0"
  gem "shoulda-matchers", "~> 5.0"
end

group :development do
  gem "web-console"
end

