# frozen_string_literal: true

require "bundler/gem_tasks"
require "minitest/test_task"

Minitest::TestTask.create

require "rubocop/rake_task"

RuboCop::RakeTask.new

namespace :test do
  desc "Run tests with verbose dummy-app Rails request logging"
  task :verbose do
    ENV["ERRORMOJI_VERBOSE_TEST_LOGS"] = "true"
    Rake::Task["test"].invoke
  end
end

task default: %i[test rubocop]
