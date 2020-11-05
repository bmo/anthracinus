require 'anthracinus/version'
require 'logger'

module Anthracinus
  # Defines constants and methods related to configuration
  module Configuration
    # An array of valid keys in the options hash when configuring a {Anthracinus::API}
    VALID_OPTIONS_KEYS = [
      :client_certificate_filename,
      :client_certificate_password,
      :client_certificate,
      :client_key,
      :ca_path,
      :default_wait,
      :default_synchronous,
      :merchant_id,
      :http_proxy,
      :api_endpoint,
      :response_format,
      :user_agent,
      :adapter,
      :faraday_options,
      :faraday_logging,
      :logger
    ].freeze

    # The adapter that will be used to connect if none is set
    DEFAULT_ADAPTER = :net_http

    # The endpoint that will be used to connect if none is set
    # This is the 'pre-production' URL
    # @note
    DEFAULT_API_ENDPOINT = 'https://apipp.blackhawknetwork.com/'.freeze

    # The response format appended to the path and sent in the 'Accept' header if none is set
    #
    # @note JSON is preferred over XML because it is more concise and faster to parse.
    DEFAULT_RESPONSE_FORMAT = :json

    # The value sent in the 'User-Agent' header if none is set
    DEFAULT_USER_AGENT = "Anthracinus gem #{Anthracinus::VERSION}".freeze

    DEFAULT_FARADAY_OPTIONS = {}.freeze

    DEFAULT_FARADAY_LOGGING = false

    DEFAULT_LOGGER = defined?(Rails) ? Rails.logger : Logger.new(STDOUT)

    DEFAULT_WAIT_MS = 15000

    DEFAULT_SYNCHRONOUS = true

    # @private
    attr_accessor(*VALID_OPTIONS_KEYS)

    # When this module is extended, set all configuration options to their default values
    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
    end

    # Create a hash of options and their values
    def options
      options = {}
      VALID_OPTIONS_KEYS.each{|k| options[k] = send(k)}
      options
    end


    
    # Reset all configuration options to defaults
    def reset
      self.adapter                      = DEFAULT_ADAPTER
      self.client_certificate_filename  = nil
      self.client_certificate_password  = nil
      self.client_certificate           = nil
      self.client_key                   = nil
      self.ca_path                      = nil
      self.api_endpoint                 = DEFAULT_API_ENDPOINT
      self.response_format              = DEFAULT_RESPONSE_FORMAT
      self.user_agent                   = DEFAULT_USER_AGENT
      self.faraday_options              = DEFAULT_FARADAY_OPTIONS
      self.logger                       = DEFAULT_LOGGER
      self.default_wait                 = DEFAULT_WAIT_MS
      self.default_synchronous          = DEFAULT_SYNCHRONOUS
      self.merchant_id                  = nil
      self.http_proxy                   = nil
    end
  end
end