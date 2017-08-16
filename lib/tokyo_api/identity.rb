module TokyoApi
  class Identity < Base
    def base_path
      'identity'
    end

    def full_user(id)
      client.get_request("#{normalized_base_path}full_user/#{id}").body
    end

    def tokyo_identity_user_path(id, phone_required)
      "/#{normalized_base_path}user/#{id}?phone_required=#{phone_required}"
    end
  end
end
