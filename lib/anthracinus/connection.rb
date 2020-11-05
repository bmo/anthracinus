require 'faraday_middleware'
#require 'faraday/response/raise_http_4xx'
#require 'faraday/response/raise_http_5xx'

module Anthracinus
  # @private
  module Connection
    private

    def connection(options = {})

      default_options = {
          headers: {
              'Accept': "application/json",
              'User-Agent': user_agent,
              'Content-Type': "application/json"
          }.merge(options.fetch(:headers)),

          ssl: {
              #verify: false,
              client_cert: options.fetch(:client_certificate, client_certificate),
              client_key: options.fetch(:client_key, client_key),
          },

          url: options.fetch(:endpoint, api_endpoint)
      }
      merged_options = default_options.merge(faraday_options)

      Faraday.new(merged_options) do |faraday|
        faraday.request :url_encoded
        faraday.proxy=http_proxy if http_proxy
        faraday.response :logger if faraday_logging
        #faraday.use Faraday::Response::RaiseHttp4xx

        faraday.use FaradayMiddleware::FollowRedirects, limit: 10

        unless options[:raw]
          case options.fetch(:format, response_format).to_s.downcase
          when 'json'
            #faraday.use Faraday::Response::Mashify
            faraday.use Faraday::Response::ParseJson
          end
        end
        #faraday.use Faraday::Response::RaiseHttp5xx
        faraday.adapter Faraday.default_adapter
      end
    end
  end
end