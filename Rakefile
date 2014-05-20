#!/usr/bin/env rake

task :app do
  require './app'
end

# require "sinatra/activerecord/rake"

task :default => [:run]

Dir[File.dirname(__FILE__) + "/lib/tasks/*.rb"].sort.each do |path|
  require path
end

desc "run app locally"
task :run => "Gemfile.lock" do
  require './app'
  MrParser::App.run!
end

# need to touch Gemfile.lock as bundle doesn't touch the file if there is no change
file "Gemfile.lock" => "Gemfile" do
  sh "bundle && touch Gemfile.lock"
end