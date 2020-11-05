require "test_helper"

class AnthracinusTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Anthracinus::VERSION
  end

  describe "Anthracinus::API" do
    def test_instantiation
      api_obj = Anthracinus::Client.new
      refute_nil api_obj
    end
    
    def test_it_does_something_useful
      assert true
    end

    def test_raises_with_no_merchant_id
      stub_request(:any, "www.example.com")
      api_obj = Anthracinus::Client.new
      assert_raises Anthracinus::Client::RequestParameterError do
        api_obj.get("http://www.example.com")
      end
      assert_not_requested :get, "http://www.example.com"
    end

    def test_connection_has_required_headers
      stub_request(:any, "www.example.com")
      api_obj = Anthracinus::Client.new
      api_obj.get("http://www.example.com", {merchant_id:'1234'})
      assert_requested(:get,
                       "http://www.example.com",times:1) do |req|
        ['Content-Type','Merchantid','Millisecondstowait','Synchronous-Only','User-Agent'].all?{ |x| req.headers.include?(x) }
      end
      
    end

    def test_connection_sets_proxy
      stub_request(:any, "www.example.com")
      api_obj = Anthracinus::Client.new(http_proxy: 'http://www.proxy.com')
      api_obj.get("http://www.example.com", {merchant_id: '1234'})
      assert_requested(:get,
                       "http://www.example.com", times: 1) do |req|
        ['Content-Type', 'Merchantid', 'Millisecondstowait', 'Synchronous-Only', 'User-Agent'].all? {|x| req.headers.include?(x)}
      end
    end

    def test_catalog_api
      stub_request(:any, 'https://apipp.blackhawknetwork.com/rewardsCatalogProcessing/v1/clientProgram/byKey?clientProgramId=1234')
      api = Anthracinus::Client.new(merchant_id:'9876')
      api.catalog("1234")
      assert_requested(:get,
                       "https://apipp.blackhawknetwork.com/rewardsCatalogProcessing/v1/clientProgram/byKey?clientProgramId=1234",
                       times: 1)
    end

    def test_order_api
      stub_request(:any, 'https://apipp.blackhawknetwork.com/rewardsOrderProcessing/v1/submitRealTimeEgiftBulk')
      api = Anthracinus::Client.new(merchant_id: '9876')

      api.order_submit_realtime(43251304, 'egift1', 25.00, 'BestBuy_eGift', '12345')

      assert_requested(:post,
                       'https://apipp.blackhawknetwork.com/rewardsOrderProcessing/v1/submitRealTimeEgiftBulk'
                       )
    end
  end
end
