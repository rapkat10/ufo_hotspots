FROM ruby:2.5.6
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN gem install bundler -v 2.1.4
RUN gem update --system
COPY Gemfile /Gemfile
COPY Gemfile.lock /Gemfile.lock
RUN bundle install
COPY . /
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]