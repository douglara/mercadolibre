require_relative '../../../minitest_helper'

class Mercadolibre::ApiTest < Minitest::Test

  def subject
    subject ||= Mercadolibre::Api.new({default_parse_response: false})
  end

  def subject_auth
    subject_auth ||= Mercadolibre::Api.new({
      app_key: ENV['APP_KEY'],
      app_secret: ENV['APP_SECRET'],
      callback_url: ENV['CALLBACK_URL'],
      site: ENV['SITE'],
      auth_url: ENV['AUTH_URL'],
      access_token: ENV['ACCESS_TOKEN'],
      default_parse_response: false
      })
  end

  def test_search_my_item_ids
    VCR.use_cassette('mercadolibre/core/items/searching/search_my_item_ids') do
      assert_equal(subject_auth.search_my_item_ids().key?(:ok) , true)
    end
  end
end
