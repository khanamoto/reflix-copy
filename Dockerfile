FROM ruby:2.6.1

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
  && apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /reflix
WORKDIR /reflix

COPY Gemfile /reflix/Gemfile
COPY Gemfile.lock /reflix/Gemfile.lock
RUN bundle install

COPY . /reflix
