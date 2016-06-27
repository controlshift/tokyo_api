module TokyoApi
  class Krautbuster < Base
    def base_path
      'krautbuster'
    end

    def full_user(session_id)
      client.get_request("#{normalized_base_path}full_user/#{session_id}").body
    end

    def user_path(session_id)
      "/#{normalized_base_path}user/#{session_id}"
    end
  end
end