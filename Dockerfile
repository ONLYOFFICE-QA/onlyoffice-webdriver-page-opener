FROM ruby:2.6

LABEL maintainer="shockwavenn@gmail.com"

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'

RUN apt-get -y update && \
    apt-get -y install google-chrome-stable \
                       xvfb
ADD . /onlyoffice-webdriver-page-opener
WORKDIR /onlyoffice-webdriver-page-opener
RUN bundle install --without development

CMD ruby main.rb
