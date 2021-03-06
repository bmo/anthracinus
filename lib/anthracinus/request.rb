module Anthracinus
  # Defines HTTP request methods
  module Request
    require 'date'
    # Perform an HTTP GET request
    def get(path, params = {}, options = {})
      request(:get, path, params, options)
    end

    def post(path, params = {}, options = {})
      request(:post, path, params, options)
    end

    # Perform an HTTP PUT request
    def put(path, params = {}, options = {})
      request(:put, path, params, options)
    end

    # Perform an HTTP DELETE request
    def delete(path, params = {}, options = {})
      request(:delete, path, params, options)
    end

    private

    def self.success?(response)
      response&.dig('response', 'status') == 1000
    end

    def datafy(params)
      {data: params}
    end

    # Perform an HTTP request
    def request(method, path, params, options)
      # all requests return a status, transaction_id, and message

      # TODO: maybe the merchant_id will be the same all the time? Default it as a config param?

      m_id = params.delete(:merchant_id) || merchant_id
      raise Anthracinus::Client::RequestParameterError.new("merchant_id must be supplied as a parameter") unless m_id
      request_id = params.delete(:request_id) || generated_request_id
      headers = {
          'merchantId': m_id,
          'requestId': request_id,
          'millisecondsToWait': (options.delete(:msec_wait) || default_wait).to_s,
          'SYNCHRONOUS_ONLY': (options.delete(:synchronous) || default_synchronous).to_s # whether we wait around for the function call
      }

      @last_request_id = request_id

      response = connection(options.merge({headers: headers})).send(method) do |request|


        case method.to_sym
        when :get, :delete
          request.url(path, params)

        when :post, :put
          request.path = path
          request.body = params.to_json  unless params.empty?
        end
      end

      @last_request_headers = response.headers&.dup
      @last_request_status = response.status

      if options[:raw]
        response
      elsif options[:headers]
        [response.body, response.headers]
      else
        response.body
      end
    end

    def generated_request_id
      # This is a "A globally unique string identifier specified by your client application, to be used during reconciliation and to facilitate idempotency.
      # Use the same RequestId to retry the same request, for instance, in the case of a timeout."
      # Practical Note: Space characters must have %20 encoding, even though + is also allowed in the URL Specs.
      # Since you don't know how your underlying libraries are going to encode it (either meets specs), best not to have spaces at all
      DateTime.now.strftime('Anthracinus_%FT%T_%6N').gsub(/:/,'_')
    end

  end
end