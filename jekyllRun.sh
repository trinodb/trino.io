#!/usr/bin/env bash
set -e

printf "\n\nStarting local Jekyll build and serving site \n\n"

bundle install
bundle exec jekyll clean
bundle exec jekyll serve --trace --incremental $@
