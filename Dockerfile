FROM ruby:3.1.2
RUN apt-get update -qq && apt-get install -y nodejs build-essential && \ apt-get libvips && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /rails 

ENV RAILS_LOG_TO_STDOUT="1" \
    RAILS_SERVE_STATIC_FILES="true" \
    RAILS_ENV="production" \
    BUNDLE_WITHOUT="development"

COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . .


RUN bundle exec bootsnap precompile --gemfile app/ lib/ vendor/bundle/

RUN SECRET_KEY_BASE_DUMMY=1 bundle exec rails assets:precompile

EXPOSE 3000
# this is the default port rails runs on
CMD ["rails", "server", "-b", "0.0.0.0"]