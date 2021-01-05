require_relative '../../../minitest_helper'

describe Mercadolibre::Core::Items do

  def subject
    subject ||= Mercadolibre::Api.new({default_parse_response: false})
  end

  describe 'update_item' do
    it 'valid item' do
      stub_request(:put, "https://api.mercadolibre.com/items/MLB1020719324?access_token=").
      to_return(status: 200, body: '{"id": "MLB1020719324"}', headers: {})
      result = subject.update_item('MLB1020719324', {'price' => 600.00})
      result.key?(:ok)
      result[:ok][:status_code] == 200
    end
  end
end