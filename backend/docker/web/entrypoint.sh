#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

# TODO DBへの変更があった際、適宜稼働
# bundle exec rails db:create RAILS_ENV=production
# bundle exec rails db:migrate RAILS_ENV=production
# bundle exec rails db:seed RAILS_ENV=production

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"