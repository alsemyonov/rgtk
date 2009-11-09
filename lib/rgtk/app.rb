require 'singleton'
require 'xdg'
require 'activesupport'
require 'rgtk/controller'

module Rgtk
  class App
    include Singleton
    attr_accessor :root_dir, :name

    def initialize
      @name = self.class.name
      @controllers = {}
      @root_dir = RGTK_ROOT
      extend_load_path
    end

    def run
      Gtk.init
      load_controllers
      if @controllers[:main]
        @controllers[:main].run
      end
      Gtk.main
    end

    def load_controllers
      Dir[File.join(controllers_dir, '**', '*')].each do |controller_file_name|
        controller_name = File.basename(controller_file_name, '.rb')
        require controller_name
        controller = controller_name.classify.constantize.new
        @controllers[controller.controller_name.to_sym] = controller
      end
    end

    def extend_load_path
      $LOAD_PATH.unshift controllers_dir
    end

    def controllers_dir
      @controllers_root ||= File.join(root_dir, 'app', 'controllers')
    end

    def view_dir
      @view_dir ||= File.join(root_dir, 'app', 'views')
    end

    def config_dir
      @config_dir ||= XDG.config_select(name)
    end
  end
end
