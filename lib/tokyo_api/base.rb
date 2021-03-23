# frozen_string_literal: true

module TokyoApi
  class Base < Vertebrae::Model
    def normalized_base_path
      "#{base_path}/"
    end

    def url_escape(string)
      CGI.escape(string.to_s)
    end

    def required_fields_param(required_fields)
      if required_fields.present?
        "required_fields=#{required_fields.collect { |v| url_escape(v.to_s) }.join(',')}"
      else
        ''
      end
    end
  end
end
