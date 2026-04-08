# syntax=docker/dockerfile:1

# Stage 1: Build
FROM ruby:3.2.2-slim AS build

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential libsqlite3-dev libvips-dev && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /rails

COPY Gemfile Gemfile.lock ./
RUN bundle config set --local without "development test" && \
    bundle install --jobs 4 && \
    rm -rf ~/.bundle/cache /usr/local/bundle/cache

COPY . .

RUN SECRET_KEY_BASE=placeholder bin/rails assets:precompile

# Stage 2: Runtime
FROM ruby:3.2.2-slim

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y libsqlite3-0 libvips sqlite3 curl && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /rails

COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

RUN mkdir -p /storage /rails/tmp/pids

COPY docker-entrypoint.sh /rails/docker-entrypoint.sh
RUN chmod +x /rails/docker-entrypoint.sh

COPY hooks/ /hooks/
RUN chmod +x /hooks/*

ENV RAILS_ENV=production \
    RAILS_LOG_TO_STDOUT=1 \
    RAILS_SERVE_STATIC_FILES=1 \
    PORT=80

EXPOSE 80

VOLUME /storage

ENTRYPOINT ["/rails/docker-entrypoint.sh"]
CMD ["bin/rails", "server"]
