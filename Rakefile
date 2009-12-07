$:.unshift(File.join(File.dirname(__FILE__), 'lib'))
 
require 'rubygems'
require 'rake'
require 'spec/rake/spectask'

desc "Run all specs"
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_files = FileList['spec/**/*spec.rb']
end

Spec::Rake::SpecTask.new("rcov:spec") do |t|
  t.spec_opts = ['--options', "\"spec/spec.opts\""]
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.rcov = true
  t.rcov_opts = lambda do
    IO.readlines("spec/rcov.opts").map {|l| l.chomp.split " "}.flatten
  end
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "yammerstats"
    gemspec.summary = "Fetch some (possibly) useful info from your Yammer domain"
    gemspec.description = "Fetches Yammer information and outputs it to the format of your choice, using Erb templates."
    gemspec.email = "workingpeter@gmail.com"
    gemspec.homepage = "http://github.com/pmoran/yammerstats"
    gemspec.authors = ["Peter Moran"]
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler"
end

task :default => [:spec]