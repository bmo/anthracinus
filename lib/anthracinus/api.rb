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
      if client_certificate_filename && client_certificate_password
        puts client_certificate_filename
        puts client_certificate_password
        p12 = OpenSSL::PKCS12.new(File.read(client_certificate_filename), client_certificate_password)
        self.client_certificate = p12.certificate
        self.client_key = p12.key
      end
    end
  end
end