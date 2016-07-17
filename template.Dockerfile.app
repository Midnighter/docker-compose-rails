FROM ruby:2.3

WORKDIR /usr/src/app
COPY ${APP_PATH}/Gemfile* ./
RUN bundle install
COPY ${APP_PATH}/* ./

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]
