module TokyoApi
  class Identity < Base
    def base_path
      'identity'
    end

    def full_user(id)
      client.get_request("#{normalized_base_path}full_user/#{url_escape(id)}").body
    end

    def tokyo_identity_user_path(id, required_fields: nil)
      path = "/#{normalized_base_path}user/#{url_escape(id)}"

      unless required_fields.nil?
        path << "?#{required_fields_param(required_fields)}"
      end
      path
    end

    def subscription_status_path(id, opt_in_external_id:, minimum_consent_level: nil)
      path = "/#{normalized_base_path}subscription_status/#{url_escape(id)}?opt_in_external_id=#{url_escape(opt_in_external_id)}"

      if minimum_consent_level
        path = "#{path}&minimum_consent_level=#{url_escape(minimum_consent_level)}"
      end

      path
    end
  end
end
