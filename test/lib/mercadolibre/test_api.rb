require_relative '../../minitest_helper'

describe Mercadolibre::Api do

  def subject
    subject ||= Mercadolibre::Api.new
  end

  describe "get_request" do
    it "valid request" do
      stub_request(:get, "https://api.mercadolibre.com/items/MLB1192787768").
      to_return(status: 200, body: "", headers: {})
      subject.send(:get_request, '/items/MLB1192787768').status_code == 200
    end
  end

  describe 'parse_response' do
    it 'enable' do
      stub_request(:get, "https://api.mercadolibre.com/items/MLB1192787768").
      to_return(status: 200, body: '{"id": "MLB1192787768"}', headers: {})

      subject.send(:get_request, '/items/MLB1192787768').id == 'MLB1192787768'
    end

    it 'disable' do
      subject = Mercadolibre::Api.new({parse_response: false})
      stub_request(:get, "https://api.mercadolibre.com/items/MLB1192787768").
      to_return(status: 200, body: '{"id": "MLB1192787768"}', headers: {})
      result = subject.send(:get_request, '/items/MLB1192787768')
      result.key?(:ok)
    end
  end

  describe 'retry_timeouts' do
    describe 'enable' do
      subject = Mercadolibre::Api.new({retry_timeouts: true, retry_timeouts_delay: 0, parse_response: false})

      it 'many requests' do
        stub_request(:get, "https://api.mercadolibre.com/items/MLB1192787768").
        to_return({status: 429, body: 'too_many_requests'}, {status: 200, body: '{"id": "MLB1192787768"}'})
  
        subject.send(:get_request, '/items/MLB1192787768')[:ok][:status_code] == 200  
      end
      it 'invalid token' do
        stub_request(:get, "https://api.mercadolibre.com/items/MLB1192787768?access_token=1234").
        to_return({status: 401, body: '{"message": "invalid_token","error": "not_found","status": 401,"cause": []}'})
  
        subject.send(:get_request, '/items/MLB1192787768?access_token=1234')[:ok][:status_code] == 401
      end

      describe 'timeout' do
        it 'parse_response enable' do
          stub_request(:get, "https://api.mercadolibre.com/items/MLB1192787768").to_timeout
  
          subject.send(:get_request, '/items/MLB1192787768')[:ok][:status_code] == nil            
        end

        it 'parse_response disable' do
          new_subject = Mercadolibre::Api.new({retry_timeouts: true, retry_timeouts_delay: 0})
          stub_request(:get, "https://api.mercadolibre.com/items/MLB1192787768").to_timeout
  
          new_subject.send(:get_request, '/items/MLB1192787768') == nil  
        end
      end
    end

    it 'disable' do
      subject = Mercadolibre::Api.new({parse_response: false})
      stub_request(:get, "https://api.mercadolibre.com/items/MLB1192787768").
      to_return({status: 429, body: 'too_many_requests'}, {status: 200, body: '{"id": "MLB1192787768"}'})
      subject.send(:get_request, '/items/MLB1192787768')[:ok][:status_code] == 429
    end

  end

end