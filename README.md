# Ruby Ovh

Client REST OVH API

Author: Maxime Désécot <maxime.desecot@gmail.com>

## Build

OS: Linux distribution LTS

Language: Ruby2.7+

```
$ apt install ruby
$ gem install bundler
$ git clone git@github.com:RaoH37/ruby-ovh.git
$ cd ruby-ovh
$ bundle install
$ gem build ruby-ovh.gemspec
```

## Installation

OS: Linux distribution LTS

Language: Ruby2.7+

```
$ apt install ruby
$ gem install bundler
$ gem install ruby-ovh-1.0.0.gem
```

## Examples of uses:

### Connection:

```ruby
client = Ovh::Application.new do |config|
  config.endpoint = :ovh_eu
  config.application_key = 'xxxxxxxxxxxxxxx'
  config.application_secret = 'xxxxxxxxxxxxxxx'
  config.consumer_key = 'xxxxxxxxxxxxxxx'
end
````
or
```ruby
client = Ovh::Application.new do |config|
  config.load_from_path('./config.json')
end
````