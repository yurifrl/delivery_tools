#!/usr/bin/env rake

require File.expand_path('../lib/shipping_watcher', __FILE__)
module Rails
  def self.config
    require 'erb'
    db_config = YAML.load(ERB.new(File.read("config/database.yml")).result)
    Struct.new(:database_configuration).new(db_config)
  end

  def self.paths
    {'db/migrate' => ["#{root}/db/migrate"]}
  end

  def self.env
    env = ENV['RACK_ENV'] || "development"
    ActiveSupport::StringInquirer.new(env)
  end

  def self.root
    File.dirname(__FILE__)
  end
end

Rake.load_rakefile "active_record/railties/databases.rake"