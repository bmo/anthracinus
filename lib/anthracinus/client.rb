module Anthracinus

  class Client < API
    # Require client method modules after initializing the Client class in
    # order to avoid a superclass mismatch error, allowing those modules to be
    # Client-namespaced.
    class InvalidParameterError < StandardError; end
    class RequestParameterError < StandardError; end

    require 'anthracinus/client/cache'
    require 'anthracinus/client/catalog'
    require 'anthracinus/client/realtime_order'
    include Anthracinus::Client::Cache
    include Anthracinus::Client::Catalog
    include Anthracinus::Client::RealtimeOrder
    
  end
end
