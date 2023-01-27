FROM ruby:2.7

ENV APP=/app

RUN curl -sL https:/deb.nodesource.com/setup_16.x | bash - && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt update && apt install -y nodejs yarn

RUN gem install bundler && \
  chmod 777 /usr/local/bundle/cache /usr/local/bundle/gems /usr/local/bundle/bin /usr/local/bundle/specifications \
    /usr/local/bundle/extensions

RUN adduser --uid 1000 --gid 0 --home ${APP} --disabled-login app
USER 1000
WORKDIR ${APP}

COPY --chown=1000 Gemfile Gemfile.lock ${APP}/
RUN bundle install

COPY --chown=1000 . ${APP}/
CMD [ "bundle", "exec", "rails", "server", "-b", "0.0.0.0" ]
