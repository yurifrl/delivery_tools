#!/usr/bin/env rake
require File.expand_path('../environment', __FILE__)

task :rails_env do
end

task :environment do
end

module Rails
  def self.application
    Struct.new(:config, :paths) do
      def load_seed
        require File.expand_path('../lib/shipping_watcher', __FILE__)
        require File.expand_path('../db/seeds', __FILE__)
      end
    end.new(config, paths)
  end

  def self.config
    require 'erb'
    db_config = YAML.load(ERB.new(File.read("config/database.yml")).result)
    Struct.new(:database_configuration).new(db_config)
  end

  def self.paths
    { 'db/migrate' => ["#{root}/db/migrate"] }
  end

  def self.env
    env = ENV['RACK_ENV'] || "development"
    ActiveSupport::StringInquirer.new(env)
  end

  def self.root
    File.dirname(__FILE__)
  end
end
Dir.glob(File.join(File.dirname(__FILE__), "./lib/**/*.rb")) do |f|
  require f
end
import File.expand_path('../lib/tasks/shipping_watcher.rake', __FILE__)
Rake.load_rakefile "active_record/railties/databases.rake"