require "bundler/setup"

Bundler.setup(:default, :development)
Bundler.require

require "paypal_express_checkout"
require "vcr"
require "active_support/all"

VCR.configure do |config|
  # Uncomment the line below to avoid error when no cassete is used in rspec test
  # This allows to mix tests with vcr and not.
  #config.allow_http_connections_when_no_cassette = true
  config.cassette_library_dir = File.dirname(__FILE__) + "/fixtures"
  config.hook_into :fakeweb
  config.configure_rspec_metadata!
end

RSpec.configure do |config|
  # config.extend VCR::RSpec::Macros **deprecated**

  config.before do
    PaypalExpressCheckout::Recurring.configure do |conf|
      conf.sandbox = true
      conf.username = "fnando.vieira+seller_api1.gmail.com"
      conf.password = "PRTZZX6JDACB95SA"
      conf.signature = "AJnjtLN0ozBP-BF2ZJrj5sfbmGAxAnf5tev1-MgK5Z8IASmtj-Fw.5pt"
      conf.seller_id = "F2RM85WS56YX2"
      conf.email = "fnando.vieira+seller.gmail.com"
    end
  end
  # Enable flags like --only-failures and --next-failure
  #config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    #c.syntax = :expect
    c.syntax = :should
  end
  config.mock_with :rspec do |c|
    c.syntax = :should
  end
end
