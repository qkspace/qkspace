source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'activerecord-sortable'
gem 'commonmarker'
gem 'devise'
gem 'devise-i18n'
gem 'font-awesome-rails'
gem 'github-markup'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'puma', '~> 3.0'
gem 'rails', '~> 5.0.2'
gem 'rails-i18n'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'sqlite3'
end

group :development do
  gem 'listen', '~> 3.0.5'
end
