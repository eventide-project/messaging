# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'messaging-postgres'
  s.version = '0.1.0.0'
  s.summary = 'Postgres messaging for Eventide'
  s.description = ' '

  s.authors = ['The Eventide Project']
  s.email = 'opensource@eventide-project.org'
  s.homepage = 'https://github.com/eventide-project/messaging-postgres'
  s.licenses = ['MIT']

  s.require_paths = ['lib']
  s.files = Dir.glob('{lib}/**/*')
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.2.3'

  s.add_runtime_dependency 'messaging'
  s.add_runtime_dependency 'event_source-postgres'

  s.add_development_dependency 'test_bench'
end
