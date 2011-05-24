require "bundler"
require "rake/testtask"

Bundler::GemHelper.install_tasks

Rake::TestTask.new do |test|
  test.pattern = "test/**/*_test.rb"
end

task :default => :test
