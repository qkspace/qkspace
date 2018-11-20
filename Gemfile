source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'activerecord-sortable'
gem 'bootstrap'
gem 'commonmarker'
gem 'devise'
gem 'devise-i18n'
gem 'font-awesome-rails'
gem 'github-markup'
gem 'jbuilder'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'puma'
gem 'rails', '~> 5.2'
gem 'rails-i18n'
gem 'sass-rails'
gem 'turbolinks'
gem 'uglifier'
gem 'http_accept_language'
gem 'tui_editor-rails'
gem 'data_migrate'
gem 'simple_form'
gem 'recaptcha'
gem 'simpleidn'

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'sqlite3'
  # gem 'i18n-tasks'
  # gem 'i18n-debug'
end

group :development do
  gem 'listen'
  gem 'letter_opener'
end
