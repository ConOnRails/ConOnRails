FROM node:lts-buster AS node

FROM ruby:2.6-buster

ENV APP=/app
ENV DATABASE_URL=postgres://db:5432

RUN gem install bundler && \
  chmod 775 /usr/local/bundle/cache /usr/local/bundle/gems /usr/local/bundle/bin /usr/local/bundle/specifications \
    /usr/local/bundle/extensions

COPY --from=node /usr/lib /usr/lib
COPY --from=node /usr/local/share /usr/local/share
COPY --from=node /usr/local/lib /usr/local/lib
COPY --from=node /usr/local/include /usr/local/include
COPY --from=node /usr/local/bin /usr/local/bin
COPY --from=node /opt /opt

RUN adduser --uid 1000 --gid 0 --home ${APP} --disabled-login app
USER 1000
WORKDIR ${APP}

ENV PATH=/usr/local/bin/:$PATH

COPY Gemfile Gemfile.lock ${APP}/
RUN bundle install

COPY package.json yarn.lock ${APP}/
RUN yarn

CMD [ "bundle", "exec", "rails", "server", "-b", "0.0.0.0" ]
