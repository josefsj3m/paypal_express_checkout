require 'spec_helper'
require 'paypal_express_checkout'

describe PaypalExpressCheckout::Recurring::Response::Payment do
  vcr_options = { cassette_name: 'payment/success' }
  context "when successful", vcr: vcr_options do
    #use_vcr_cassette "payment/success"

    subject {
      ppr = PaypalExpressCheckout::Recurring.new({
        :description => "Awesome - Monthly Subscription",
        :amount      => "9.00",
        :currency    => "BRL",
        :payer_id    => "D2U7M6PTMJBML",
        :token       => "EC-5H387177LU0538626" #"EC-7DE19186NP195863W",
      })
      ppr.request_payment
    }

    it { should be_valid }
    it { should be_completed }
    it { should be_approved }

    its(:errors) { should be_empty }
  end

  vcr_options1 = { cassette_name: 'payment/failure' }
  context "when failure", vcr: vcr_options1 do
    #use_vcr_cassette("payment/failure")
    subject { PaypalExpressCheckout::Recurring.new.request_payment }

    it { should_not be_valid }
    it { should_not be_completed }
    it { should_not be_approved }

    its(:errors) { should have(2).items }
  end
end
