module TokyoApi
  class Krautbuster < Base
    def base_path
      'krautbuster'
    end

    def full_user(session_id)
      client.get_request("#{normalized_base_path}full_user/#{session_id}").body
    end

    def session_status(session_id)
      client.get_request("#{normalized_base_path}session_status/#{session_id}").body
    end

    def subscription_status(token)
      begin
        client.get_request(subscription_status_path(token)).body
      rescue Vertebrae::ResponseError => e
        # Status 404 is expected in these calls
        if e.status_code == 404
          return nil
        end

        raise
      end
    end

    def user_path(session_id, petition_id:, required_fields: nil)
      path = "/#{normalized_base_path}user/#{session_id}?petition_id=#{petition_id}"
      unless required_fields.nil?
        path << "&required_fields=#{required_fields.join(',')}"
      end
      path
    end

    def subscription_status_path(token)
      "/#{normalized_base_path}subscription_status/#{token}"
    end
  end
end
