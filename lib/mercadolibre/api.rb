module Mercadolibre
  class Api
    attr_accessor :access_token, :site

    def initialize(args={})
      @app_key = args[:app_key]
      @app_secret = args[:app_secret]
      @callback_url = args[:callback_url]
      @access_token = args[:access_token]

      if args.key?(:endpoint_url)
        @endpoint_url = args[:endpoint_url]
      else
        @endpoint_url = 'https://api.mercadolibre.com'
      end

      if args.key?(:auth_url)
        @auth_url = args[:auth_url]
      else
        @auth_url = 'https://auth.mercadolibre.com.ar'
      end

      @site = args[:site]

      args.key?(:retry_timeouts_delay) ? @retry_timeouts_delay = args[:retry_timeouts_delay] : @retry_timeouts_delay = 15
      args.key?(:retry_timeouts_limit) ? @retry_timeouts_limit = args[:retry_timeouts_limit] : @retry_timeouts_limit = 5
      args.key?(:retry_timeouts) ? @retry_timeouts = args[:retry_timeouts] : @retry_timeouts = false
      args.key?(:parse_response) ? @parse_response = args[:parse_response] : @parse_response = true
    end

    include Mercadolibre::Core::Apps
    include Mercadolibre::Core::Bookmarks
    include Mercadolibre::Core::Categories
    include Mercadolibre::Core::Currencies
    include Mercadolibre::Core::Deals
    include Mercadolibre::Core::Feedbacks
    include Mercadolibre::Core::ItemVariations
    include Mercadolibre::Core::Items
    include Mercadolibre::Core::Listings
    include Mercadolibre::Core::Locations
    include Mercadolibre::Core::Messaging
    include Mercadolibre::Core::Metrics
    include Mercadolibre::Core::Money
    include Mercadolibre::Core::Oauth
    include Mercadolibre::Core::OrderBlacklist
    include Mercadolibre::Core::OrderNotes
    include Mercadolibre::Core::Orders
    include Mercadolibre::Core::PickupStores
    include Mercadolibre::Core::Pictures
    include Mercadolibre::Core::Projects
    include Mercadolibre::Core::QuestionBlacklist
    include Mercadolibre::Core::Questions
    include Mercadolibre::Core::Searching
    include Mercadolibre::Core::Shipping
    include Mercadolibre::Core::Users

    def get_last_response
      @last_response
    end

    def get_last_result
      @last_result
    end

    private

    def get_request(action, params={}, headers={})
      begin
        retries ||= 0
        api_response_kind = headers.delete('api_response_kind')
        api_response_kind = headers.delete(:api_response_kind) if api_response_kind.nil?
        api_response_kind = 'object' if api_response_kind.nil?

        parse_response(api_response_kind, RestClient.get("#{@endpoint_url}#{action}", {params: params}.merge(headers)))
      rescue RestClient::ExceptionWithResponse, RestClient::TooManyRequests => e
        if (@retry_timeouts == true)
          sleep(@retry_timeouts_delay)
          retry if (retries += 1) < @retry_timeouts_limit
        end
        parse_response('object', e.response)
      rescue Exception => e
        parse_response('object', e.response)
      end
    end

    def post_request(action, params={}, headers={})
      begin
        retries ||= 0
        api_response_kind = headers.delete('api_response_kind')
        api_response_kind = headers.delete(:api_response_kind) if api_response_kind.nil?
        api_response_kind = 'object' if api_response_kind.nil?

        parse_response(api_response_kind, RestClient.post("#{@endpoint_url}#{action}", params, headers))
      rescue RestClient::ExceptionWithResponse, RestClient::TooManyRequests => e
        if (@retry_timeouts == true)
          sleep(@retry_timeouts_delay)
          retry if (retries += 1) < @retry_timeouts_limit
        end
        parse_response('object', e.response)
      rescue Exception => e 
        parse_response('object', e.response)
      end
    end

    def put_request(action, params={}, headers={})
      begin
        retries ||= 0
        api_response_kind = headers.delete('api_response_kind')
        api_response_kind = headers.delete(:api_response_kind) if api_response_kind.nil?
        api_response_kind = 'object' if api_response_kind.nil?

        parse_response(api_response_kind, RestClient.put("#{@endpoint_url}#{action}", params, headers))
      rescue RestClient::ExceptionWithResponse, RestClient::TooManyRequests => e
        if (@retry_timeouts == true)
          sleep(@retry_timeouts_delay)
          retry if (retries += 1) < @retry_timeouts_limit
        end
        parse_response('object', e.response)
      rescue Exception => e 
        parse_response('object', e.response)
      end
    end

    def patch_request(action, params={}, headers={})
      begin
        retries ||= 0
        api_response_kind = headers.delete('api_response_kind')
        api_response_kind = headers.delete(:api_response_kind) if api_response_kind.nil?
        api_response_kind = 'object' if api_response_kind.nil?

        parse_response(api_response_kind, RestClient.patch("#{@endpoint_url}#{action}", params, headers))
      rescue RestClient::ExceptionWithResponse, RestClient::TooManyRequests => e
        if (@retry_timeouts == true)
          sleep(@retry_timeouts_delay)
          retry if (retries += 1) < @retry_timeouts_limit
        end
        parse_response('object', e.response)
      rescue Exception => e 
        parse_response('object', e.response)
      end
    end

    def head_request(action, params={}, headers={})
      begin
        retries ||= 0
        api_response_kind = headers.delete('api_response_kind')
        api_response_kind = headers.delete(:api_response_kind) if api_response_kind.nil?
        api_response_kind = 'object' if api_response_kind.nil?

        parse_response(api_response_kind, RestClient.head("#{@endpoint_url}#{action}", params))
      rescue RestClient::ExceptionWithResponse, RestClient::TooManyRequests => e
        if (@retry_timeouts == true)
          sleep(@retry_timeouts_delay)
          retry if (retries += 1) < @retry_timeouts_limit
        end
        parse_response('object', e.response)
      rescue Exception => e 
        parse_response('object', e.response)
      end
    end

    def delete_request(action, params={}, headers={})
      begin
        retries ||= 0
        api_response_kind = headers.delete('api_response_kind')
        api_response_kind = headers.delete(:api_response_kind) if api_response_kind.nil?
        api_response_kind = 'object' if api_response_kind.nil?

        parse_response(api_response_kind, RestClient.delete("#{@endpoint_url}#{action}", params))
      rescue RestClient::ExceptionWithResponse, RestClient::TooManyRequests => e
        if (@retry_timeouts == true)
          sleep(@retry_timeouts_delay)
          retry if (retries += 1) < @retry_timeouts_limit
        end
        parse_response('object', e.response)
      rescue Exception => e 
        parse_response('object', e.response)
      end
    end

    def parse_response(api_response_kind, response)
      if (@parse_response == false)
        return { 
          ok: { 
            response: response, 
            body: (JSON.parse(response.body) rescue response.body),
            status_code: response.code
          }}
      end

      @last_response = response

      result = OpenStruct.new
      result.status_code = response.code

      if api_response_kind == 'object'
        result.headers = (JSON.parse(response.headers.to_json, object_class: OpenStruct) rescue response.headers)
        result.body = (JSON.parse(response.body, object_class: OpenStruct) rescue response.body)
      elsif api_response_kind == 'hash'
        result.headers = response.headers
        result.body = (JSON.parse(response.body) rescue response.body)
      else
        result.headers = response.headers
        result.body = response.body
      end

      @last_result = result

      result
    end
  end
end
