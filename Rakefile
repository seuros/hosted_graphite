require 'rake/testtask'

require 'bundler/gem_tasks'

task default: :test

Rake::TestTask.new(:test) do |t|
  t.pattern = 'test/test_*.rb'
  t.verbose = true
end
