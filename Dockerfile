FROM ruby:3.2.2-alpine

# Install system dependencies
RUN apk --update add \
      build-base \
      mariadb-dev \
      postgresql-dev \
      sqlite-dev \
      su-exec \
      tini && \
    gem update --system && \
    gem install bundler:2.4.17 && \
    rm -rf /var/cache/apk/*

ENV GEMSTASH_HOME="/home/dokku"
ENV GEMSTASH_APP_DIR="${GEMSTASH_HOME}/app"
ENV BUNDLE_PATH="${GEMSTASH_HOME}/.gems"

# Add user/group dokku
RUN addgroup -g "32767" "dokku" && \
    adduser -S -D -u "32767" -G "dokku" "dokku"
USER dokku

# Install Gemstash
RUN mkdir -p "${GEMSTASH_APP_DIR}"
WORKDIR "${GEMSTASH_APP_DIR}"
COPY "app/" "${GEMSTASH_APP_DIR}"
RUN bundle install --jobs 4 --retry 3

# Run
CMD ["bundle", "exec", "gemstash", "start", "--no-daemonize", "--config-file=config.yml.erb"]
