module TokyoApi
  class Expire < Base
    def base_path
      'expire'
    end

    def organisation(host)
      client.get_request("#{normalized_base_path}organisation/#{host}").body
    end
  end
end