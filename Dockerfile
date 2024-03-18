FROM ruby:3.3.0-alpine

RUN apk update && apk upgrade && apk add --no-cache \
  bash \
  make \
  build-base \
  sqlite \
  git

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

EXPOSE 3000
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
