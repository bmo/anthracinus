require 'anthracinus/authentication'
require 'anthracinus/configuration'
require 'anthracinus/connection'
require 'anthracinus/request'
require 'openssl'


module Anthracinus
  class API
    include Connection
    include Request
    include Authentication

    attr_accessor(*Configuration::VALID_OPTIONS_KEYS)
    
    attr_reader :last_request_id, :last_request_headers

    def last_request_id
      @last_request_id
    end

    def last_request_headers
      @last_request_headers
    end
    # Creates a new API
    def initialize(options = {})
      options = Anthracinus.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
      init_cache
      setup_cert
    end

    def setup_cert
      if (client_certificate_filename || client_certificate) && client_certificate_password
        p12 = OpenSSL::PKCS12.new(client_certificate || File.read(client_certificate_filename), client_certificate_password)
        self.client_certificate = p12.certificate
        self.client_key = p12.key
      end
    end
  end
end