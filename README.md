# trino.io

The source for the Trino community website available at
[https://trino.io/](https://trino.io/).

The site uses [Jekyll](https://jekyllrb.com/) and markdown.

## Build and Run Locally

In general, you need Ruby, gems, Bundler and Jekyll.

Detailed steps for macOS follow below. Similar commands work for various Linux
distros.

## macOS

Initial setup:

Install ruby in brew:

```bash
brew install ruby
```

Add brew ruby in front of system ruby:

```bash
PATH=/usr/local/opt/ruby/bin:$PATH
```

Install bundler:

```bash
gem install bundler
```

Install gems for site:

```bash
bundle install
```

Run server:

```bash
bundle exec jekyll serve
```

With the server running you can access the site on
[http://localhost:4000](http://localhost:4000).

## Additional Notes

### Verify pages render correctly on phone

You can run the server on your computer and then verify the pages render
correctly on a phone.  By default the server only binds to localhost, so it is
not accessible on your local network.  Add `--host 0.0.0.0` to the `bundle exec`
command to have the server bind to the external IP addresses on your computer.

### View future posts

Posts with future dates do not normally render.  Add `--future` to the `bundle
exec` command to see these.
