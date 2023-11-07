FROM ruby:3.1

# install rails dependencies
# RUN apk add --update build-base bash bash-completion libffi-dev tzdata postgresql-client postgresql-dev nodejs npm yarn
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs postgresql

# create a folder /app in the docker container and go into that folder
RUN mkdir /app
WORKDIR /app

# Copy the Gemfile and Gemfile.lock from app root directory into the /app/ folder in the docker container
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

# Run bundle install to install gems inside the gemfile
RUN gem install bundler
RUN bundle lock --add-platform x86_64-linux
RUN bundle install

# Copy the whole app
COPY . /app