# frozen_string_literal: true

module TokyoApi
  class Client < Vertebrae::API
    def actionkit
      @actionkit ||= TokyoApi::Actionkit.new(client: self)
    end

    alias action_kit actionkit

    def campact
      @campact ||= TokyoApi::Campact.new(client: self)
    end

    def identity
      @identity ||= TokyoApi::Identity.new(client: self)
    end

    def external_image
      @external_image ||= TokyoApi::ExternalImage.new(client: self)
    end

    def expire
      @expire ||= TokyoApi::Expire.new(client: self)
    end

    def default_options
      opts = {
        user_agent: 'TokyoApi Gem',
        prefix: '',
        content_type: 'application/json'
      }

      if initialisation_options.key?(:timeout)
        opts[:connection_options] = { request: { timeout: initialisation_options[:timeout] } }
      end

      opts
    end

    def request(method, path, params, options) # :nodoc:
      raise ArgumentError, "unknown http method: #{method}" unless ::Vertebrae::Request::METHODS.include?(method)

      path = "#{connection.configuration.prefix}/#{path}" unless connection.configuration.prefix.blank?

      ::Vertebrae::Base.logger.debug "EXECUTED: #{method} - #{path} with #{params} and #{options}"

      connection.connection.send(method) do |request|
        case method.to_sym
        when *(::Vertebrae::Request::METHODS - ::Vertebrae::Request::METHODS_WITH_BODIES)
          request.url(path, params)
        when *::Vertebrae::Request::METHODS_WITH_BODIES
          request.path = path
          request.body = extract_data_from_params(params) unless params.empty?
        end
      end
    end

    def setup
      connection.faraday_connection = Faraday.new(connection.configuration.faraday_options) do |f|
        f.request :multipart
        f.request :url_encoded
        if connection.configuration.authenticated?
          f.request :authorization, :basic, connection.configuration.username, connection.configuration.password
        end

        f.response :logger if ENV['DEBUG']
        f.response :mashify
        f.response :json

        f.use Vertebrae::Response::RaiseError
        f.adapter connection.configuration.adapter
      end
    end
  end
end
