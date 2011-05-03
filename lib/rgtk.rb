require 'activesupport/core_ext/module/attribute_accessors'

$KCODE = 'UTF-8' if RUBY_VERSION[0..3] == '1.8.'

module Rgtk
  mattr_accessor :root

  autoload :App,        'rgtk/app'
  autoload :Config,     'rgtk/config'
  autoload :Controller, 'rgtk/controller'
end
