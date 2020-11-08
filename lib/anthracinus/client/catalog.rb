# operations related to the HI catalog
require 'anthracinus/client/service_urls'

module Anthracinus
  class Client
    include Anthracinus::Client::ServiceUrls

    module Catalog
      def catalog(client_program_id, options={})
        get(Anthracinus::Client::ServiceUrls::CATALOG_BYKEY_API_URL, {'clientProgramId': client_program_id}, options)
      end

      def catalog_for_suborg(sub_org_id,options={})
        get(Anthracinus::Client::ServiceUrls::CATALOG_SUBORG_API_URL, {'subOrgId': sub_org_id }, options)

      end
    end
  end
end 