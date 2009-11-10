module Rgtk
  module Controller
    class Base
      extend Rgtk::Controller::DSL
      attr_accessor :builder, :view_name, :objects

      def self.controller_name
        self.name.underscore.sub(/_controller$/, '')
      end

      def controller_name
        @_controller_name
      end

      def initialize
        @_controller_name = self.class.controller_name
        load_objects
      end

      def run
        container.show
      end

      def [](object_name)
        @_children[object_name.to_s]
      end

      def method_missing(method_name, *args)
        if @_children.key?(method_name)
          self[method_name]
        else
          super(method_name, *args)
        end
      end

    protected
      # Main view container
      # @return [Gtk::Container] conventionally named container
      def container
        self[:container]
      end

      # Find the view name from controller name
      # @return [String] full path to view name
      def view_name
        unless @_view_name
          self.view_name = controller_name
        end
        @_view_name
      end

      # Set the view name if it does not match controller’s one
      # @param [String] view name without path and ".ui" extension
      # @return [String] full path to view name
      def view_name=(view_name)
        @_view_name = File.join(::App.views_dir, "#{view_name}.ui")
        raise "Error: no view provided for #{self.class.name} (should be in #{@_view_name})" unless File.exists?(@_view_name)
      end

      # Initialize (if doesn’t) and return builder for controller
      # @return [Gtk::Builder] actual builder
      def builder
        unless @_builder
          @_builder = Gtk::Builder.new
          @_builder << view_name
          @_builder.connect_signals do |handler|
            method(handler)
          end
        end
        @_builder
      end

      def load_objects
        @_children = builder.objects.inject({}) do |children, object|
          children[object.name.sub(/^#{controller_name}_/, '')] = object
          children
        end.with_indifferent_access
      end

      def flunk(message = "Flunked")
        puts message
      end
    end
  end
end
