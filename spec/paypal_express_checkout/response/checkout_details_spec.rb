require 'spec_helper'
require 'paypal_express_checkout'

describe PaypalExpressCheckout::Recurring::Response::Details do
  vcr_options = { cassette_name: 'details/success' }
  context "when successful", vcr: vcr_options do
    #use_vcr_cassette "details/success" **deprecated**

    subject {
      ppr = PaypalExpressCheckout::Recurring.new(:token => "EC-08C2125544495393T")
      ppr.checkout_details
    }

    it { should be_valid }
    it { should be_success }

    its(:errors) { should be_empty }
    its(:status) { should == "PaymentActionNotInitiated" }
    its(:email) { should == "fnando.vieira+br@gmail.com" }
    its(:requested_at) { should be_a(Time) }
    its(:payer_id) { should == "D2U7M6PTMJBML" }
    its(:payer_status) { should == "unverified" }
    its(:country) { should == "BR" }
    its(:currency) { should == "BRL" }
    its(:description) { should == "Awesome - Monthly Subscription" }
    its(:ipn_url) { should == "http://example.com/paypal/ipn" }
    its(:agreed?) { should be_true }
  end

  vcr_options1 = {cassette_name: 'details/cancelled'}
  context "when cancelled", vcr: vcr_options1 do
    #use_vcr_cassette "details/cancelled" **deprecated**
    subject {
      ppr = PaypalExpressCheckout::Recurring.new(:token => "EC-8J298813NS092694P")
      ppr.checkout_details
    }

    it { should be_valid }
    it { should be_success }

    its(:agreed?) { should be false }
  end

  vcr_options2 = {cassette_name: 'details/failure'}
  context "when failure", vcr: vcr_options2 do
    #use_vcr_cassette("details/failure") **deprecated**
    subject { PaypalExpressCheckout::Recurring.new.checkout_details }

    it { should_not be_valid }
    it { should_not be_success }

    its(:errors) { should have(1).item }
  end
end
