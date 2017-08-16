module TokyoApi
  class Bluestatedigital < Base
    def base_path
      'bluestatedigital'
    end

    def full_user(id)
      client.get_request("#{normalized_base_path}full_user/#{id}").body
    end

    def tokyo_blue_state_digital_user_path(id, phone_required)
      "/#{normalized_base_path}constituent/#{id}?phone_required=#{phone_required}"
    end
  end
end