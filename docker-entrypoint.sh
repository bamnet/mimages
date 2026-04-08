#!/bin/bash
set -e

# Run pending migrations automatically on startup
bin/rails db:prepare

exec "$@"
