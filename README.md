# Ruby Ovh

Client REST OVH API

Author: Maxime Désécot <maxime.desecot@gmail.com>

## Build

OS: Linux distribution LTS

Language: Ruby3.1+

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
$ gem install ruby-ovh-0.3.0.gem
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
or you can also initialize your connection from a configuration file :
```ruby
client = Ovh::Application.new do |config|
  config.load_from_path('./config.json')
end
````

### Usage

In reference to online documentation

https://eu.api.ovh.com/

ruby-ovh is used as follows:

```ruby
# For call using http GET method
client.get("/ws/call/path/")

# For call using http POST method
client.post("/ws/call/path/", data: {})

# For call using http PUT method
client.put("/ws/call/path/", data: {})

# For call using http DELETE method
client.delete("/ws/call/path/")
````