#!/bin/bash

set -e -x

bundle install --quiet
bundle exec rubocop .
bundle exec rspec -f progress
