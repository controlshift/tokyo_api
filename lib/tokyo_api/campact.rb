# frozen_string_literal: true

module TokyoApi
  class Campact < Base
    def base_path
      'campact'
    end

    def full_user(session_id)
      client.get_request("#{normalized_base_path}full_user/#{url_escape(session_id)}").body
    end

    def session_status(session_id)
      client.get_request("/#{normalized_base_path}session/#{url_escape(session_id)}/status").body
    end

    def destroy_session(session_id)
      client.delete_request("/#{normalized_base_path}session/#{url_escape(session_id)}").status == 204
    end

    def subscription_status(token)
      client.get_request(subscription_status_path(token)).body
    rescue Vertebrae::ResponseError => e
      # Status 404 is expected in these calls
      return nil if e.status_code == 404

      raise
    end

    def user_path(session_id, petition_id:, with_subscription_status: false, required_fields: nil)
      path = "/#{normalized_base_path}user/#{url_escape(session_id)}?petition_id=#{url_escape(petition_id)}"
      path << '&with_subscription_status=true' if with_subscription_status
      path << "&#{required_fields_param(required_fields)}" unless required_fields.nil?
      path
    end

    def subscription_status_path(token)
      "/#{normalized_base_path}subscription_status/#{url_escape(token)}"
    end
  end
end
