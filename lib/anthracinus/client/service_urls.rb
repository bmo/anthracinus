module Anthracinus
  class Client
    module ServiceUrls
      CATALOG_API_URL = 'rewardsCatalogProcessing/v1/clientProgram/byKey'
      CATALOG_SUBORG_API_URL = 'rewardsCatalogProcessing/v1/clientProgramsBySubOrg'
      ORDER_REALTIME_BULK_URL = 'rewardsOrderProcessing/v1/submitRealTimeEgiftBulk'
      ORDER_REALTIME_VIRTUAL_URL = 'rewardsOrderProcessing/v1/submitRealTimeVirtualIndividual'
      ORDER_INFO_URL = 'rewardsOrderProcessing/v1/orderInfo/byKeys'

    end
  end
end