require 'spec_helper'

describe PaypalExpressCheckout::Recurring do
  describe ".new" do
    it "instantiates PaypalExpressCheckout::Recurring::Base" do
      PaypalExpressCheckout::Recurring.new.should be_a(PaypalExpressCheckout::Recurring::Base)
    end
  end

  describe ".version" do
    it "returns PaypalExpressCheckout's API version" do
      PaypalExpressCheckout::Recurring.api_version.should eq("204.0")
    end
  end

  describe ".configure" do
    it "yields PaypalExpressCheckout::Recurring" do
      PaypalExpressCheckout::Recurring.configure do |config|
        config.should be(PaypalExpressCheckout::Recurring)
      end
    end

    it "sets attributes" do
      PaypalExpressCheckout::Recurring.configure do |config|
        config.sandbox = false
      end

      PaypalExpressCheckout::Recurring.sandbox.should be false
    end
  end

  describe ".sandbox?" do
    it "detects sandbox" do
      PaypalExpressCheckout::Recurring.sandbox = true
      PaypalExpressCheckout::Recurring.should be_sandbox
    end

    it "ignores sandbox" do
      PaypalExpressCheckout::Recurring.sandbox = false
      PaypalExpressCheckout::Recurring.should_not be_sandbox
    end
  end

  describe ".environment" do
    it "returns production" do
      PaypalExpressCheckout::Recurring.sandbox = false
      PaypalExpressCheckout::Recurring.environment.should eq(:production)
    end

    it "returns sandbox" do
      PaypalExpressCheckout::Recurring.sandbox = true
      PaypalExpressCheckout::Recurring.environment.should eq(:sandbox)
    end
  end

  describe ".api_endpoint" do
    it "returns url" do
      PaypalExpressCheckout::Recurring.api_endpoint.should_not be_nil
      PaypalExpressCheckout::Recurring.api_endpoint.should == PaypalExpressCheckout::Recurring.endpoints[:api]
    end
  end

  describe ".site_endpoint" do
    it "returns url" do
      PaypalExpressCheckout::Recurring.site_endpoint.should_not be_nil
      PaypalExpressCheckout::Recurring.site_endpoint.should == PaypalExpressCheckout::Recurring.endpoints[:site]
    end
  end

  describe ".endpoints" do
    it "returns production's" do
      PaypalExpressCheckout::Recurring.sandbox = false
      PaypalExpressCheckout::Recurring.endpoints.should eq(PaypalExpressCheckout::Recurring::ENDPOINTS[:production])
    end

    it "returns sandbox's" do
      PaypalExpressCheckout::Recurring.sandbox = true
      PaypalExpressCheckout::Recurring.endpoints.should eq(PaypalExpressCheckout::Recurring::ENDPOINTS[:sandbox])
    end
  end
end
