module Mercadolibre
  module Core
    module Items
      def create_item(attrs)
        payload = attrs.to_json

        headers = { content_type: :json }

        result = post_request("/items?access_token=#{@access_token}", payload, headers)
        @default_parse_response == true ? result.body : result
      end

      def get_item(item_id, attrs={})
        request = get_request("/items/#{item_id}", attrs.merge({ access_token: @access_token }))
        response = @last_response && @last_response&.code == 200 ? {ok: request} : {error: request}
        @default_parse_response == true ? request.body : response
      end

      def get_items(item_ids, attrs={})
        result = get_request("/items", attrs.merge({ids: item_ids.uniq.join(','), access_token: @access_token}))
        @default_parse_response == true ? result.body : result
      end

      def update_item(item_id, attrs)
        payload = attrs.to_json

        headers = { content_type: :json, accept: :json }

        request = put_request("/items/#{item_id}?access_token=#{@access_token}", payload, headers)
        response = @last_response && @last_response&.code == 200 ? {ok: request} : {error: request}
        @default_parse_response == true ? request.body : response
      end

      def validate_item(attrs)
        payload = attrs.to_json

        headers = { content_type: :json }

        result = post_request("/items/validate?access_token=#{@access_token}", payload, headers)

        (result.status_code.to_s == '204')
      end

      def get_item_available_upgrades(item_id)
        result = get_request("/items/#{item_id}/available_upgrades?access_token=#{@access_token}")
        @default_parse_response == true ? result.body : result
      end

      def relist_item(item_id, attrs)
        payload = attrs.to_json

        headers = { content_type: :json, accept: :json }

        result = post_request("/items/#{item_id}/relist?access_token=#{@access_token}", payload, headers)
        @default_parse_response == true ? result.body : result
      end

      def get_item_description(item_id)
        result = get_request("/items/#{item_id}/description")
        @default_parse_response == true ? result.body : result
      end

      def update_item_description(item_id, text)
        payload = { text: text }.to_json

        headers = { content_type: :json, accept: :json }

        result = put_request("/items/#{item_id}/description?access_token=#{@access_token}", payload, headers)
        @default_parse_response == true ? result.body : result
      end

      def update_item_attributes(item_id, attrs)
        payload = attrs.to_json

        headers = { content_type: :json, accept: :json }

        result = put_request("/items/#{item_id}?access_token=#{@access_token}", payload, headers)
        @default_parse_response == true ? result.status_code == 200 : result
      end

      def delete_item_attributes(item_id, attr_list)
        payload = attr_list.map { |x| { id: x } }.to_json

        headers = { content_type: :json, accept: :json }

        result = put_request("/items/#{item_id}?access_token=#{@access_token}", payload, headers)
        @default_parse_response == true ? result.status_code == 200 : result
      end

      def get_item_identifiers(item_id)
        result = get_request("/items/#{item_id}/product_identifiers")
        @default_parse_response == true ? result.body == 200 : result
      end

      def update_item_identifiers(item_id, attrs)
        payload = attrs.to_json

        headers = { content_type: :json }

        result = put_request("/items/#{item_id}/product_identifiers?access_token=#{@access_token}", payload, headers)
        @default_parse_response == true ? result.status_code == 200 : result
      end
    end
  end
end
