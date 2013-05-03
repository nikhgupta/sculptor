#!/usr/bin/env ruby
# encoding: utf-8

require 'yaml'
require 'thor'

module Sculptor

  # Use the file: ~/.sculptor/data.yml to specify path of this directory,
  # as well as, the directories to load tasks from.
  # This ensures that we can simply install this task globally, and yet,
  # have access to all tasks.
  def self.configuration
    YAML.load_file File.join(ENV['HOME'], ".sculptor", "data.yml")
  end

  def self.load_thorfiles(dir)
    Dir.chdir(dir) do
      thor_files = Dir.glob('**/*.thor').delete_if { |x| not File.file?(x) }
      thor_files.each do |f|
        Thor::Util.load_thorfile(f)
      end
    end
  end
end

# load configuration for our Sculptor
config = Sculptor::configuration

# load tasks from the specified directories
config["task_dirs"].each do |dir|
  dir = File.expand_path(dir, config["path"])
  Sculptor.load_thorfiles dir
end
