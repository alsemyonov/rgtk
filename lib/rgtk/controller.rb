require 'activesupport'
require 'gtk2'

module Rgtk
  class Controller
    attr_accessor :builder, :view_name, :objects

    def controller_name
      @@controller_name ||= self.class.name.underscore.sub(/_controller$/, '')
    end

    def initialize
      @application = Rgtk::App.instance
      load_view
    end

    def run
      window.show
    end

    def method_missing(method_name, *args)
      puts method_name, *args
      @builder.get_object(method_name.to_s)
    end

  protected
    def window
      @builder.get_object("#{controller_name}_window")
    end

    def load_view
      @builder = Gtk::Builder.new
      @builder << view_name
      @builder.connect_signals do |handler|
        method(handler)
      end
    end

    def view_name
      unless @view_name
        @view_name = File.join(@application.views_dir, controller_name + '.ui')
        raise "Error: no view provided for #{self.class.name}" unless File.exists?(@view_name)
      end
      @view_name
    end
  end
end
