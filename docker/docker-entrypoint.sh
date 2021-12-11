#!/bin/bash

set -e

if [ "$1" = 'puma' ]; then
  echo 'Starting puma'
  #exec bundle exec puma ${@:2}
  exec ./start-entrypoint.sh

elif [ "$1" = 'jobs' ]; then
  echo 'Starting jobs'
  exec bundle exec rails jobs:work ${@:2}

elif [ "$1" = 'rails' ]; then
  exec bundle exec rails ${@:2}

elif [ "$1" = 'setup' ]; then
  echo 'Setup database'
  exec bundle exec rails db:create db:structure:load db:seed ${@:2}

elif [ "$1" = 'fakedata' ]; then
  exec bundle exec rake fake_data:responsible

elif [ "$1" = 'migrate' ]; then
  echo 'Update database'
  exec bundle exec rails db:migrate

elif [ "$1" = 'assets' ]; then
  echo 'Precompile assets'
  exec bundle exec rails assets:precompile

else
  exec "$@"
fi