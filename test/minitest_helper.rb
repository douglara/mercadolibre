require 'minitest/autorun'
require 'minitest/pride'
require 'dotenv/load'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'mercadolibre'

require 'webmock/minitest'
WebMock.enable!
Dir[File.expand_path("../support/**/*.rb", __FILE__)].each { |rb| require(rb) }