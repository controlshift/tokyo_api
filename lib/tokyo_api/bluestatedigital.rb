module TokyoApi
  class Actionkit < Base
    def base_path
      'bluestatedigital'
    end

    def full_user(id)
      client.get_request("#{normalized_base_path}full_user/#{id}").body
    end
  end
end