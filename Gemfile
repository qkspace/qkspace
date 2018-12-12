source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'activerecord-sortable'
gem 'bootstrap'
gem 'commonmarker'
gem 'data_migrate'
gem 'font-awesome-rails'
gem 'github-markup'
gem 'http_accept_language'
gem 'jbuilder'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'passwordless', github: 'EugZol/passwordless'
gem 'puma'
gem 'rails', '~> 5.2'
gem 'rails-i18n'
gem 'recaptcha'
gem 'sass-rails'
gem 'simpleidn'
gem 'simple_form'
gem 'tui_editor-rails'
gem 'turbolinks'
gem 'uglifier'

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'sqlite3'
  # gem 'i18n-tasks'
  # gem 'i18n-debug'
end

group :development do
  gem 'letter_opener'
  gem 'listen'
end
