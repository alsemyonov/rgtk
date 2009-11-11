require 'singleton'
require 'xdg'
require 'activesupport'

module Rgtk
  class App
    include Singleton

    def initialize
      @name = self.class.name
      @controllers = {}
      @loggers = {}
      extend_load_path
    end

    def root
      Rgtk.root
    end

    def app_name
      @app_name ||= self.class.name.underscore.gsub(/_app/, '')
    end

    def run
      Gtk.init
      load_models
      load_controllers
      if defined?(:MainController)
        @controllers[:main] = MainController.new
        @controllers[:main].run
      end
      Gtk.main
    end

    def extend_load_path
      $LOAD_PATH.unshift(controllers_dir)
      $LOAD_PATH.unshift(models_dir)
    end

    def load_controllers
      Dir[File.join(controllers_dir, '**', '*')].each do |controller_file_name|
        controller_name = File.basename(controller_file_name, '.rb')
        require controller_name
      end
    end

    def load_models
      connect_db if config.use_db?
      Dir[File.join(models_dir, '**', '*')].each do |model_file_name|
        model_name = File.basename(model_file_name, '.rb')
        require model_name
      end
    end

    %w(models views controllers).each do |mvc|
      class_eval <<-END_SRC, __FILE__, __LINE__
        def #{mvc}_dir
          @#{mvc}_dir ||= File.join(Rgtk.root, 'app', '#{mvc}')
        end
      END_SRC
    end

    def config
      unless @config
        @config = Rgtk::Config.new
      end
      @config
    end

    def logger(kind = :application)
      @loggers[kind] ||= Logger.new(File.open(data_file("#{kind}.log"), 'a'))
    end

    def connect_db
      require 'activerecord'
      config.database ||= {:adapter => 'sqlite3',
                           :database => data_file("#{app_name}.sqlite3")}
      ActiveRecord::Base.establish_connection(config.database.symbolize_keys!)
      ActiveRecord::Base.logger = logger(:database)
    end

    %w(config data cache).each do |kind|
      class_eval <<-END_SRC, __FILE__, __LINE__
        def #{kind}_dir                         # def config_dir
          @#{kind}_dir ||= xdg_dir(:#{kind})    #   @confid_dir ||= xdg_dir(:config)
        end                                     # end

        def #{kind}_file(file_name)             # def config_file(file_name)
          File.join(#{kind}_dir, file_name)     #   File.join(config_dir, file_name)
        end                                     # end
      END_SRC
    end

    def destroy
      config.save! unless config.autosave? == false
      Gtk.main_quit
    end

  protected
    # Return xdg dir, autocreate if it does not present
    # @param [String] :config, :data or :cache - kind of xdg dir
    def xdg_dir(kind)
      dirs = XDG.send(:"#{kind}_select", app_name)
      if dirs.empty?
        returning(File.join(XDG.send(:"#{kind}_home"), app_name)) do |dir_name|
          Dir.mkdir(dir_name)
        end
      else
        dirs.first
      end
    end
  end
end
