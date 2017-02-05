# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'evt-messaging-postgres'
  s.version = '0.6.0.0'
  s.summary = 'Postgres messaging for Eventide'
  s.description = ' '

  s.authors = ['The Eventide Project']
  s.email = 'opensource@eventide-project.org'
  s.homepage = 'https://github.com/eventide-project/messaging-postgres'
  s.licenses = ['MIT']

  s.require_paths = ['lib']
  s.files = Dir.glob('{lib}/**/*')
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.3.3'

  s.add_runtime_dependency 'evt-messaging'
  s.add_runtime_dependency 'evt-event_source-postgres'

  s.add_development_dependency 'test_bench'
end
