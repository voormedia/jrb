# encoding: utf-8
require "jeweler"
require "rake/testtask"

Jeweler::Tasks.new do |spec|
  spec.name = "jrb"
  spec.rubyforge_project = "jrb"
  spec.summary = "JRB templates are Just Ruby."
  spec.description = "JRB is a collection of utilities to use Ruby code as templates. It provides a set of optional helpers that allow you to build output efficiently. A Rails adapter is included."

  spec.authors = ["Rolf Timmermans"]
  spec.email = "r.timmermans@voormedia.com"
  spec.homepage = "http://rails-erd.rubyforge.org/"
end

Jeweler::GemcutterTasks.new

Jeweler::RubyforgeTasks.new do |rubyforge|
  rubyforge.doc_task = "rdoc"
  rubyforge.remote_doc_path = "doc"
end

Rake::TestTask.new do |test|
  test.pattern = "test/unit/**/*_test.rb"
end

task :default => :test
