require 'rake/testtask'

task :default => :test

Rake::TestTask.new do |t|
  t.name = :test
  t.pattern = 'test/test_*.rb'
  t.options = '"--no-show_detail_immediately"'
  t.warning = false
end
