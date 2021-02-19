module Mercadolibre
  module Core
    module Searching
      def search_items(filters={})
        filters.merge!({ access_token: @access_token })
        
        get_request("/sites/#{@site}/search", filters).body
      end

      def search_item_ids(filters={})
        search_items(filters).results.map(&:id)
      end

      def search_my_item_ids(filters={})
        user_id = filters[:user_id] || get_my_user[:ok]['id']

        filters.merge!({limit: 50, offset: 0 })

        request = get_request("/users/#{user_id}/items/search", filters)
        response = @last_response && @last_response&.code == 200 ? {ok: @last_body} : {error: @last_body}
        @default_parse_response == true ? request.body : response
      end

      def get_search_url(site_id, q)
        get_request("/sites/#{site_id}/searchUrl?q=#{q}").body
      end

      def get_hot_items(site_id, category_id, limit=15)
        get_request("/sites/#{site_id}/hot_items/search?category=#{category_id}&limit=#{limit}").body
      end

      def get_featured_items(site_id, pool_id)
        get_request("/sites/#{site_id}/featured_items/#{pool_id}").body
      end
    end
  end
end
