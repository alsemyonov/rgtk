require 'activesupport'
$KCODE = 'UTF-8'

module Rgtk
  mattr_accessor :root
end

require 'rgtk/app'
require 'rgtk/config'
require 'rgtk/controller'
