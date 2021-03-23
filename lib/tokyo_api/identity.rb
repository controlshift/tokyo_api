# frozen_string_literal: true

module TokyoApi
  class Identity < Base
    def base_path
      'identity'
    end

    def full_user(id)
      client.get_request("#{normalized_base_path}full_user/#{url_escape(id)}").body
    end

    def tokyo_identity_user_path(id, with_subscription_status: false, required_fields: nil, opt_in_public_ids: nil, minimum_consent_level: nil, encrypted: nil)
      path = "/#{normalized_base_path}user/#{url_escape(id)}"

      params = []
      params << required_fields_param(required_fields) unless required_fields.nil?

      if with_subscription_status
        params << 'with_subscription_status=true'
        additional_subscription_parameters = path_for_subscription_status_params(opt_in_public_ids,
                                                                                 minimum_consent_level, encrypted)
        params << additional_subscription_parameters unless additional_subscription_parameters.blank?
      end

      path << "?#{params.join('&')}" if params.any?

      path
    end

    def subscription_status_path(id, opt_in_public_ids: nil, minimum_consent_level: nil, encrypted: nil)
      raise 'must provide opt_in_public_ids' if opt_in_public_ids.nil?

      "/#{normalized_base_path}subscription_status/#{url_escape(id)}?#{path_for_subscription_status_params(
        opt_in_public_ids, minimum_consent_level, encrypted
      )}"
    end

    private

    def path_for_subscription_status_params(opt_in_public_ids, minimum_consent_level, encrypted = nil)
      path = ''

      path = "opt_in_public_ids=#{url_escape(opt_in_public_ids.join(','))}" if opt_in_public_ids.present?

      path << "&minimum_consent_level=#{url_escape(minimum_consent_level)}" if minimum_consent_level

      path << '&encrypted=1' if encrypted

      path
    end
  end
end
