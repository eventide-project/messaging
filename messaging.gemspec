# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'evt-messaging'
  s.version = '2.7.0.1'
  s.summary = 'Eventide messaging for Postgres'
  s.description = ' '

  s.authors = ['The Eventide Project']
  s.email = 'opensource@eventide-project.org'
  s.homepage = 'https://github.com/eventide-project/messaging'
  s.licenses = ['MIT']

  s.require_paths = ['lib']
  s.files = Dir.glob('{lib}/**/*')
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.4.0'

  ## Remove after message store is published w/ pg dependency
  s.add_runtime_dependency 'pg'

  s.add_runtime_dependency 'evt-message_store'
  s.add_runtime_dependency 'evt-settings'

  s.add_development_dependency 'test_bench'
end
