require 'anthracinus/api'
require 'anthracinus/client'
require 'anthracinus/configuration'

module Anthracinus
  extend Configuration
  class << self
    # Alias for Anthracinus::Client.new
    #
    # @return [Anthracinus::Client]
    def new(options={})
      Anthracinus::Client.new(options)
    end

    private
    # Delegate to Omnicard::Client
    def method_missing(method, *args, &block)
      return super unless new.respond_to?(method)
      new.send(method, *args, &block)
    end

    def respond_to?(method, include_private = false)
      new.respond_to?(method, include_private) || super(method, include_private)
    end
  end
end
