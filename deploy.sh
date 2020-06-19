#!/bin/bash

git pull &&
bundle install --deployment --without development test &&
RAILS_ENV=production bundle exec rake assets:precompile &&
RAILS_ENV=production bundle exec rake db:migrate &&
RAILS_ENV=production bundle exec rake data:migrate &&
RAILS_ENV=production bundle exec rake og_images:generate &&
bundle exec sidekiq -e production &
touch tmp/restart.txt
