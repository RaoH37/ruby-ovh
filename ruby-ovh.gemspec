# frozen_string_literal: true

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'ovh-rest-client'
  s.version     = File.read(File.expand_path('./OVH_VERSION', __dir__)).strip
  s.summary     = 'Client REST for OVH API'
  s.description = ''

  s.required_ruby_version = '>= 3.1'
  s.required_rubygems_version = '>= 1.8.11'

  s.license = 'GPL-3.0-only'

  s.author   = 'Maxime Désécot'
  s.email    = 'maxime.desecot@gmail.com'
  s.homepage = 'https://github.com/RaoH37/ruby-ovh'

  s.files = `git ls-files`.split("\n")
  s.require_path = %w[lib]

  s.add_dependency('faraday', ['>= 2.12'])
  s.metadata['rubygems_mfa_required'] = 'true'
end
