FROM ruby:2.6

ENV APP=/app
ENV DATABASE_URL=postgres://db:5432

RUN gem install bundler && \
  chmod 775 /usr/local/bundle/cache /usr/local/bundle/gems /usr/local/bundle/bin /usr/local/bundle/specifications \
    /usr/local/bundle/extensions

RUN adduser --uid 1000 --gid 0 --home ${APP} --disabled-login app
USER 1000
WORKDIR ${APP}

COPY Gemfile Gemfile.lock ${APP}/
RUN bundle install

CMD [ "bundle", "exec", "rails", "server", "-b", "0.0.0.0" ]
