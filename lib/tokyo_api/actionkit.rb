module TokyoApi
  class Actionkit < Base
    def base_path
      'actionkit'
    end

    def full_user(id)
      client.get_request("#{normalized_base_path}full_user/#{url_escape(id)}").body
    end

    def user_path(id, required_fields: nil)
      path = "/#{normalized_base_path}user/#{url_escape(id)}"
      unless required_fields.nil?
        path << "?#{required_fields_param(required_fields)}"
      end
      path
    end
  end
end
