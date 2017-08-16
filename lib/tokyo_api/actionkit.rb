module TokyoApi
  class Actionkit < Base
    def base_path
      'actionkit'
    end

    def full_user(id)
      client.get_request("#{normalized_base_path}full_user/#{id}").body
    end

    def user_path(id, phone_required)
      "/#{normalized_base_path}user/#{id}?phone_required=#{phone_required}"
    end
  end
end