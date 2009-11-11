module Rgtk
  module Controller
    class About
      def dialog
        unless @dialog
          @dialog = Gtk::AboutDialog.new
          @gem_name = ::App.app_name

          gem @gem_name
          @spec = Gem.loaded_specs[@gem_name]

          @dialog.program_name = @spec.summary
          @dialog.comments = @spec.description
          @dialog.version = @spec.version.to_s
          @dialog.website = @spec.homepage
          @dialog.authors = [@spec.author]

          @dialog.signal_connect('response') do |dialog, button|
            dialog.hide if button == Gtk::Dialog::RESPONSE_CANCEL
          end
        end
        @dialog
      end

      def show
        dialog.show
      end

      def hide
        dialog.hide
      end
    end
  end
end
