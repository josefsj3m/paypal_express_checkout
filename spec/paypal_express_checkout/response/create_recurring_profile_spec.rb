require 'spec_helper'
require 'paypal_express_checkout'

describe PaypalExpressCheckout::Recurring::Response::Profile do
  vcr_options = { cassette_name: 'create_profile/success' }
  context "when successful", vcr: vcr_options do
    #use_vcr_cassette "create_profile/success"

    subject {
      ppr = PaypalExpressCheckout::Recurring.new({
        :amount                => "9.00",
        :initial_amount        => "9.00",
        :initial_amount_action => :cancel,
        :currency              => "BRL",
        :description           => "Awesome - Monthly Subscription",
        :ipn_url               => "http://example.com/paypal/ipn",
        :frequency             => 1,
        :token                 => "EC-47J551124P900104V",
        :period                => :monthly,
        :reference             => "1234",
        :payer_id              => "D2U7M6PTMJBML",
        :start_at              => Time.now,
        :failed                => 1,
        :outstanding           => :next_billing
      })
      ppr.create_recurring_profile
    }

    it { should be_valid }

    its(:profile_id) { should == "I-W4FNTE6EXJ2W" }
    its(:status) { should == "ActiveProfile" }
    its(:errors) { should be_empty }
  end

  vcr_options1 = { cassette_name: 'create_profile/failure' }
  context "when failure", vcr: vcr_options1 do
    #use_vcr_cassette("create_profile/failure")
    subject { PaypalExpressCheckout::Recurring.new.create_recurring_profile }

    it { should_not be_valid }
    its(:errors) { should have(5).items }
  end
end
