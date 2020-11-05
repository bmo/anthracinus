# operations related to the HI catalog
require 'anthracinus/client/service_urls'

module Anthracinus
  class Client
    include Anthracinus::Client::ServiceUrls

    module Catalog
      def catalog(client_program_id)
        get(Anthracinus::Client::ServiceUrls::CATALOG_API_URL, 'clientProgramId': client_program_id)
      end

      def catalog_for_suborg(sub_org_id)
        get(Anthracinus::Client::ServiceUrls::CATALOG_SUBORG_API_URL, 'subOrgId': sub_org_id)

      end
    end
  end
end 