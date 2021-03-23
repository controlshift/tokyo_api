# frozen_string_literal: true

module TokyoApi
  class Bluestatedigital < Base
    def base_path
      'bluestatedigital'
    end

    def full_user(id)
      client.get_request("#{normalized_base_path}full_user/#{url_escape(id)}").body
    end

    def tokyo_blue_state_digital_user_path(id, required_fields: nil)
      path = "/#{normalized_base_path}constituent/#{url_escape(id)}"
      path << "?#{required_fields_param(required_fields)}" unless required_fields.nil?
      path
    end
  end
end
