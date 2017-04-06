# -*- encoding: utf-8 -*-
require 'spec_helper'
require 'paypal_express_checkout'

describe PaypalExpressCheckout::Recurring::Response::Profile do
  vcr_options = { cassette_name: 'profile/success' }
  context "when successful", vcr: vcr_options do
    #use_vcr_cassette "profile/success"
    let(:paypal) { PaypalExpressCheckout::Recurring.new(:profile_id => "I-W4FNTE6EXJ2W") }
    subject { paypal.profile }

    it { should_not be_active }

    its(:status) { should == :canceled }
    its(:profile_id) { should == "I-W4FNTE6EXJ2W" }
    its(:outstanding) { should == :next_billing }
    its(:description) { should == "Awesome - Monthly Subscription" }
    its(:payer_name) { should == "José da Silva" }
    its(:reference) { should == "1234" }
    its(:failed) { should == "1" }
    its(:start_at) { should be_a(Time) }
    its(:completed) { should == "0" }
    its(:remaining) { should == "0" }
    its(:outstanding_balance) { should == "0.00" }
    its(:failed_count) { should == "0" }
    its(:last_payment_date) { should be_a(Time) }
    its(:last_payment_amount) { should == "9.00" }
    its(:period) { should == :monthly }
    its(:frequency) { should == "1" }
    its(:currency) { should == "BRL" }
    its(:amount) { should == "9.00" }
    its(:initial_amount) { should == "9.00" }
  end

  vcr_options1 = { cassette_name: 'profile/failure' }
  context "when failure", vcr: vcr_options1 do
    #use_vcr_cassette "profile/failure"
    let(:paypal) { PaypalExpressCheckout::Recurring.new(:profile_id => "invalid") }
    subject { paypal.profile }

    it { should_not be_valid }
    it { should_not be_success }

    its(:errors) { should have(1).item }
  end
end
