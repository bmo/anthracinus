module Anthracinus
  class Client
    module ServiceUrls
      CATALOG_BYKEY_API_URL = 'rewardsCatalogProcessing/v1/clientProgram/byKey'
      CATALOG_SUBORG_API_URL = 'rewardsCatalogProcessing/v1/clientProgramsBySubOrg'

      ORDER_REALTIME_BULK_URL = 'rewardsOrderProcessing/v1/submitRealTimeEgiftBulk'
      ORDER_REALTIME_VIRTUAL_URL = 'rewardsOrderProcessing/v1/submitRealTimeVirtualBulk'
      ORDER_INFO_URL = 'rewardsOrderProcessing/v1/orderInfo/byKeys'
      ORDER_BULK_URL = 'rewardsOrderProcessing/v1/submitEgiftBulk'
      ORDER_BULK_VIRTUAL_URL = 'rewardsOrderProcessing/v1/submitVirtualBulk'
      ORDER_VIRTUAL_CODES_URL = 'rewardsOrderProcessing/v1/virtualCodeRetrievalInfo/byKeys'
      ORDER_EGIFT_CODES_URL = 'rewardsOrderProcessing/v1/eGiftBulkCodeRetrievalInfo/byKeys'
    end
  end
end