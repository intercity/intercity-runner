FROM ruby:2.3
MAINTAINER Jeroen van Baarsen (jeroen@firmhouse.com)

# make sure we are up to date
RUN apt-get update

# Setup Python dependencies
RUN apt-get install -y python-setuptools python-dev
RUN easy_install pip
RUN pip install paramiko PyYAML Jinja2 httplib2 six

# Install ansible
RUN pip install ansible

# Setup bundler
RUN bundle config --global frozen 1

# Ensure proper caching for gems
COPY Gemfile ./
COPY Gemfile.lock ./
RUN bundle install

COPY . ./

CMD ["./runner.rb"]
