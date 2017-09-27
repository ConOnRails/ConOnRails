FROM ruby:2.3.5

RUN apt-get update -qq
RUN apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    sqlite3

RUN mkdir /app

WORKDIR /app

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock

RUN gem install bundler

RUN bundle install

ADD . /app

CMD bundle exec rails s -p 3000 -b '0.0.0.0'
