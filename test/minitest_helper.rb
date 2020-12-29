require 'minitest/autorun'
require 'minitest/pride'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'mercadolibre'

require 'webmock/minitest'
WebMock.enable!
