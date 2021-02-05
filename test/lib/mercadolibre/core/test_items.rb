require_relative '../../../minitest_helper'

describe Mercadolibre::Core::Items do

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


  describe 'update_item' do
    it 'valid item' do
      VCR.use_cassette('mercadolibre/core/items/update_item/valid item') do
        assert_equal(subject_auth.update_item('MLB1775469478', {'price' => 600.00}).key?(:ok) , true)
      end
    end

    it 'invalid item' do
      VCR.use_cassette('mercadolibre/core/items/update_item/invalid item') do
        assert_equal(subject_auth.update_item('MLB1020719324', {'price' => 600.00}).key?(:error) , true)
      end
    end
  end

  describe 'get_item', :vcr do
    it 'valid item' do
      VCR.use_cassette('mercadolibre/core/items/get_item/valid item') do
        assert_equal(subject.get_item('MLB1020719324').key?(:ok) , true)
      end
    end

    it 'not found item' do
      VCR.use_cassette('mercadolibre/core/items/get_item/not found item') do
        assert_equal(subject.get_item('MLB102071932').key?(:error) , true)
      end
    end
  end

  describe '#update_item_description', :vcr do
    it 'valid item' do
      VCR.use_cassette('mercadolibre/core/items/update_item_description/valid item') do
        assert_equal(subject_auth.update_item_description('MLB1788182235', 'test')[:status_code] , 200)
      end
    end
  end
end