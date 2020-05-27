FROM ruby:2.6.3
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /project
WORKDIR /project
COPY Gemfile Gemfile.lock ./
RUN gem install bundler --no-document
RUN bundle install --no-binstubs --jobs $(nproc) --retry 3
COPY . .
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
