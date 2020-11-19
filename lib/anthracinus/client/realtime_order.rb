require 'anthracinus/client/service_urls'

module Anthracinus
  class Client
    include Anthracinus::Client::ServiceUrls

    module RealtimeOrder
      # purchase_order_number up to 50 chars
      def order_submit_realtime(client_pgm_number, client_ref_id, amount, content_provider_id, purch_order_number, return_card_and_pin = true, payment_type = :draw_down, options = {})

        c_r_id = client_ref_id.to_s
        pmt_type = payment_type.to_s.upcase
        unless validate_payment_type(pmt_type)
          raise InvalidParameterError.new('Payment type must be one of DRAW_DOWN or ACH_DEBIT')
        end

        if purch_order_number && purch_order_number.size > 50
          raise InvalidParameterError.new('Purchase order string must be < 50 characters')
        end

        unless validate_client_ref(c_r_id)
          raise InvalidParameterError.new('Client Reference ID contains invalid characters')
        end

        order_detail = {
            'clientRefId': c_r_id, # something unique
            'amount': amount.to_s,
            'quantity': '1', # must be one for this API
            'contentProvider': content_provider_id # from the catalog
        }
        params = {
            'clientProgramNumber': client_pgm_number.to_s,
            'paymentType': pmt_type,
            'poNumber': purch_order_number.to_s,
            'returnCardNumberAndPIN': return_card_and_pin.to_s,
            'orderDetails': [order_detail]
        }
        puts("Params #{params.inspect}")
        post(Anthracinus::Client::ServiceUrls::ORDER_REALTIME_BULK_URL, params, options)
      end

      def order_submit_realtime_virtual(client_pgm_number, client_ref_id, amount, purch_order_number, return_card_and_pin = true, payment_type = :draw_down, options = {})
        c_r_id = client_ref_id.to_s
        pmt_type = payment_type.to_s.upcase

        unless validate_client_ref(c_r_id)
          raise InvalidParameterError.new('Client Reference ID contains invalid characters')
        end

        unless validate_payment_type(pmt_type)
          raise InvalidParameterError.new('Payment type must be one of DRAW_DOWN or ACH_DEBIT')
        end

        if purch_order_number && purch_order_number.size > 50
          raise InvalidParameterError.new('Purchase order string must be < 50 characters')
        end

        order_detail = {
            'clientRefId': c_r_id, # something unique
            'amount': amount.to_s,
            'quantity': '1' # must be one for this API

        }
        params = {
            'clientProgramNumber': client_pgm_number.to_s,
            'paymentType': pmt_type,
            'poNumber': purch_order_number.to_s,
            'orderDetails': [order_detail]

        }
        puts params.inspect
        post(Anthracinus::Client::ServiceUrls::ORDER_REALTIME_VIRTUAL_URL, params, options)
      end

      def get_realtime_order(transaction_id, options = {})
        get(Anthracinus::Client::ServiceUrls::ORDER_REALTIME_BULK_URL + "/#{transaction_id}", options)
      end

      def get_realtime_virtual_order(transaction_id, options = {})
        get(Anthracinus::Client::ServiceUrls::ORDER_REALTIME_VIRTUAL_URL + "/#{transaction_id}", options)
      end

      def get_virtual_codes(order_number, request_id = nil, client_pgm_number = nil, options = {})
        if order_number
          params = {
              'orderNumber': order_number
          }
        else
          params = {
              'requestId': request_id,
              'clientProgramNumber': client_pgm_number
          }
        end
        get(Anthracinus::Client::ServiceUrls::ORDER_VIRTUAL_CODES_URL, params, options)
      end

      def get_egift_codes(order_number, options = {})
        params = {
            'orderNumber': order_number
        }
        get(Anthracinus::Client::ServiceUrls::ORDER_EGIFT_CODES_URL, params, options)
      end

      # retrieve the order with variable params
      def order(order_number, request_id = nil, client_pgm_number = nil, options = {})
        raise InvalidParameterError.new('Order: Order number or request_id AND client_pgm_number must be supplied') unless order_number || (request_id && client_pgm_number)
        if order_number
          params = {
              'orderNumber': order_number
          }
        else
          params = {
              'requestId': request_id,
              'clientProgramNumber': client_pgm_number
          }
        end
        get(Anthracinus::Client::ServiceUrls::ORDER_INFO_URL, params, options)
      end

      def validate_client_ref(clientref)
        clientref.match(/^[0-9a-zA-Z\s.,\/'\-]*$/)
      end

      def validate_payment_type(pmt_type)
        ['DRAW_DOWN', 'ACH_DEBIT'].include?(pmt_type)
      end

    end
  end
end

