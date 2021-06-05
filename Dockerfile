FROM ruby:3.0.1-alpine

ENV APP_ROOT /app 

# Configure the main working directory. This is the base 
# directory used in any further RUN, COPY, and ENTRYPOINT 
# commands.

RUN mkdir -p $APP_ROOT
WORKDIR $APP_ROOT

# Expose port 3000 to the Docker host, so we can access it 
# from the outside.
EXPOSE 3000

# Install apt based dependencies required to run Rails as 
# well as RubyGems. As the Ruby image itself is based on a 
# Debian image, we use apt-get to install those.
RUN apk update && \
    apk upgrade && \
    apk add --update --virtual build-dependencies \
    git \
    bash curl-dev ruby-dev build-base\
    zlib-dev libxml2-dev libxslt-dev tzdata yaml-dev postgresql-dev postgresql-client \
    ruby-json yaml nodejs imagemagick\
    linux-headers && \
    rm -rf /var/cache/apk/*
  
# Copy the Gemfile as well as the Gemfile.lock and install 
# the RubyGems. This is a separate step so the dependencies 
# will be cached unless changes to one of those two files 
# are made.
COPY Gemfile Gemfile.lock ./ 
RUN gem install bundler && \
    bundle config build.nokogiri --use-system-libraries && \
    QMAKE=/usr/lib/qt5/bin/qmake bundle install && \
    bundle clean --force

# Copy the main application.
COPY . ./
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]