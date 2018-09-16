#! /usr/bin/env bash
set -e

bundle check || bundle install
bundle exec rake db:create
bundle exec rake db:schema:load
