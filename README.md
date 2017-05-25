# CapistranoTheBestCompression

Optimized assets compressor for Capistrano.

### Getting Started

Add the best compression to your Gemfile and `bundle install`:

```ruby
gem 'capistrano-the-best-compression', git: 'git@github.com:SumatoSoft/capistrano-the-best-compression.git'
```

Run on your server:

```bash
$ sudo apt-get install zopfli
$ cd /tmp && git clone https://github.com/google/zopfli.git && cd zopfli && make zopflipng && sudo mv zopflipng /usr/bin/
```

Add to your Capfile:

```ruby
require 'capistrano/the_best_compression'
```

And to deploy.rb:

```ruby
before 'deploy:publishing', 'deploy:compress_assets'
before 'deploy:publishing', 'deploy:compress_png'
```

