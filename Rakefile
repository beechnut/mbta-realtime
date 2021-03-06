# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://guides.rubygems.org/specification-reference/ for more options
  gem.name        = "mbta-realtime"
  gem.homepage    = "http://github.com/beechnut/mbta-realtime"
  gem.license     = "MIT"
  gem.summary     = %Q{Get schedules, predictions, and other data from the MBTA Realtime V2 API}
  gem.description = %Q{The MBTA Realtime V2 API unifies "schedule, alert, 
                       vehicle position, and arrival prediction data". The MBTA Realtime gem
                       provides a Ruby interface to the API, presenting results using
                       sensible Ruby defaults.}
  gem.email       = "cloydster@gmail.com"
  gem.authors     = ["Matt Cloyd"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

desc "Code coverage detail"
task :simplecov do
  ENV['COVERAGE'] = "true"
  Rake::Task['test'].execute
end

task :default => :test

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "mbta-realtime #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
