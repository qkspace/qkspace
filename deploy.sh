#!/bin/bash

git pull &&
bundle install --deployment --without development test &&
RAILS_ENV=production bundle exec rake assets:precompile &&
RAILS_ENV=production bundle exec rake db:migrate &&
RAILS_ENV=production bundle exec rake data:migrate &&
touch tmp/restart.txt
