module TokyoApi
  class Bluestatedigital < Base
    def base_path
      'bluestatedigital'
    end

    def full_user(id)
      client.get_request("#{normalized_base_path}full_user/#{id}").body
    end

    def tokyo_blue_state_digital_user_path(id, required_fields: nil)
      path = "/#{normalized_base_path}constituent/#{id}"
      unless required_fields.nil?
        path << "?required_fields=#{required_fields.collect{|v| CGI.escape(v.to_s)}.join(',')}"
      end
      path
    end
  end
end
