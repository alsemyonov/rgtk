require 'rgtk'

module Rgtk
  class Config
    def initialize(file_name = 'config.yml')
      @file_name = File.join(::App.config_dir, file_name)
      @config = if File.exists?(@file_name)
                  YAML.load_file(@file_name) || {}
                else
                  `touch #{@file_name}`
                  {}
                end.to_hash.with_indifferent_access
    end

    def method_missing(method_name, *args)
      if method_name.to_s =~ /^([a-z0-9_]+)=$/
        @config[$1] = args.first
      else
        @config[method_name]
      end
    end

    def [](name)
      @config[name]
    end

    def []=(name, value)
      @config[name] = value
    end

    def save!
      File.open(@file_name, 'w') { |f| f.write(@config.to_yaml) }
    end
  end
end
