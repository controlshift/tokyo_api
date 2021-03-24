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
      connection.stack do |builder|
        builder.use Faraday::Request::Multipart
        builder.use Faraday::Request::UrlEncoded
        if connection.configuration.authenticated?
          builder.use Faraday::Request::BasicAuthentication, connection.configuration.username,
                      connection.configuration.password
        end

        builder.use Faraday::Response::Logger if ENV['DEBUG']

        builder.use FaradayMiddleware::Mashify
        builder.use FaradayMiddleware::ParseJson

        builder.use Vertebrae::Response::RaiseError
        builder.adapter connection.configuration.adapter
      end
    end
  end
end
