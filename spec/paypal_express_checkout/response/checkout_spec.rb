require 'spec_helper'
require 'paypal_express_checkout'

describe PaypalExpressCheckout::Recurring::Response::Checkout do
  vcr_options = { cassette_name: 'checkout/success' }
  context "when successful", vcr: vcr_options do
    #use_vcr_cassette "checkout/success"

    subject {
      ppr = PaypalExpressCheckout::Recurring.new({
        :return_url         => "http://example.com/thank_you",
        :cancel_url         => "http://example.com/canceled",
        :ipn_url            => "http://example.com/paypal/ipn",
        :description        => "Awesome - Monthly Subscription",
        :amount             => "9.00",
        :currency           => "USD"
      })

      ppr.checkout
    }

    its(:valid?) { should be_true }
    its(:errors) { should be_empty }
    its(:checkout_url) { should == "#{PaypalExpressCheckout::Recurring.site_endpoint}?cmd=_express-checkout&token=EC-6K296451S2213041J&useraction=commit" }
  end

  vcr_options1 = { cassette_name: 'checkout/failure' }
  context "when failure", vcr: vcr_options1 do
    # use_vcr_cassette("checkout/failure")
    subject { PaypalExpressCheckout::Recurring.new.checkout }

    its(:valid?) { should be_false }
    its(:errors) { should have(3).items }
  end
end
