FROM ruby:3.1


ARG RAILS_ENV
ARG ENVIRONMENT_KEY

# install rails dependencies
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg -o /root/yarn-pubkey.gpg && apt-key add /root/yarn-pubkey.gpg
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs yarn postgresql

# create a folder /app in the docker container and go into that folder
RUN mkdir /app
WORKDIR /app

# Copy the Gemfile and Gemfile.lock from app root directory into the /app/ folder in the docker container
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

# Run bundle install to install gems inside the gemfile
RUN gem install bundler
RUN bundle install
RUN bundle lock --add-platform x86_64-linux

# Copy the whole app
COPY . /app

# Setting up the credentials
RUN echo $ENVIRONMENT_KEY > config/credentials/$RAILS_ENV.key

# install node packages
RUN yarn install

# Precompile assets
RUN bundle exec rake assets:precompile RAILS_ENV=$RAILS_ENV