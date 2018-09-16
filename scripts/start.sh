#! /usr/bin/env bash
set -e

bundle check || bundle install

until psql -h db -U nickjohs -l > /dev/null
do
  sleep 2
done

if ! psql -h db -U nickjohs -l | grep myapp_development > /dev/null
then
  echo "Running Setup"
  /home/docker/scripts/setup.sh
fi

rm /home/docker/tmp/pids/server.pid || true

bundle exec rake db:migrate
bin/rails s
