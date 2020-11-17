require 'anthracinus/client/service_urls'

module Anthracinus
  class Client
    include Anthracinus::Client::ServiceUrls

    module Order
      def order_bulk_submit(client_pgm_number, client_ref_id, amount, content_provider_id, purch_order_number, return_card_and_pin = true, payment_type = :draw_down, options)
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
        post(Anthracinus::Client::ServiceUrls::ORDER_BULK_URL, params, options)
      end

      def order_bulk_virtual_submit(client_pgm_number, client_ref_id, amount, purch_order_number, return_card_and_pin = true, payment_type = :draw_down, options = {})
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
        puts("Params #{params.inspect}")

        post(Anthracinus::Client::ServiceUrls::ORDER_BULK_VIRTUAL_URL, params, options)
      end
    end
  end
end
