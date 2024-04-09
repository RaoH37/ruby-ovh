# frozen_string_literal: true

lib = File.expand_path('lib')
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)

require 'ruby-ovh'

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'ruby-ovh'
  s.version     = Ovh.gem_version.to_s
  s.summary     = 'Client REST for OVH API'
  s.description = ''

  s.required_ruby_version = '>= 2.7'

  s.license = 'MIT'

  s.author   = 'Maxime Désécot'
  s.email    = 'maxime.desecot@gmail.com'
  s.homepage = 'https://github.com/RaoH37/ruby-ovh'

  s.files = `git ls-files`.split("\n")
  s.require_path = %w[lib]

  s.add_dependency('faraday', ['2.9.0'])
end
