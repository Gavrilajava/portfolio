#!/usr/bin/env sh

bundle exec rake db:migrate
bundle exec puma -C config/docker_puma.rb -p 8080