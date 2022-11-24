# frozen_string_literal: true

module TokyoApi
  class ExternalImage < Base
    def base_path
      'external_image'
    end

    def track_download(photo_id)
      client.post_request("#{normalized_base_path}#{url_escape(photo_id)}/download").status == 204
    end
  end
end
