FROM ruby:2.6

LABEL maintainer="shockwavenn@gmail.com"

ADD . /onlyoffice-webdriver-page-opener
WORKDIR /onlyoffice-webdriver-page-opener
RUN bundle install

RUN ruby script.rb
