require_relative 'test_init'

TestBench::Runner.(
  'interactive/**/*.rb',
  exclude_pattern: %r{\/_|sketch|(_init\.rb|_tests\.rb)\z}
) or exit 1
