module Rgtk
  module Controller
    module DSL
      def shortcuts(shortcut_hash)
        shortcut_hash.each do |key, name|
          define_method key do
            builder.get_object(name)
          end
        end
      end

      def signals_for(object)
        _current_object.push(object)
        yield
        _current_object.pop
      end

      def on(action, &block)
        callback_name = "#{signal_prefix}_#{action}"
        defined = instance_method(callback_name) rescue false
        raise "#{callback_name} is already defined in #{self}" if defined
        if block_given?
          define_method(callback_name, &block)
        else
          define_method(callback_name) do
            flunk "No implementation provided for #{callback_name}"
          end
        end
      end
      alias_method :signal, :on

      %w(activate toggled changed).each do |signal|
        class_eval <<-END_SRC, __FILE__, __LINE__
          def #{signal}(object_name, &block)
            on("\#{object_name}_#{signal}", &block)
          end
        END_SRC
      end

    protected
      def signal_prefix
        if _current_object.empty?
          'on'
        else
          "on_#{_current_object.join('_')}"
        end
      end

      def _current_object
        @_current_object ||= []
      end
    end
  end
end
