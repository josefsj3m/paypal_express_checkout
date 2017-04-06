require 'spec_helper'
require 'paypal_express_checkout'

describe PaypalExpressCheckout::Recurring::Response::Profile do
  vcr_options = { cassette_name: 'update_profile/success' }
  context "when successful", vcr: vcr_options do
    #use_vcr_cassette "update_profile/success"

    let(:paypal) {
      PaypalExpressCheckout::Recurring.new({
        :description => "Awesome - Monthly Subscription (Updated)",
        :amount      => "10.00",
        :currency    => "BRL",
        :note        => "Changed Plan",
        :profile_id  => "I-6BWVV63V49JT"
      })
    }

    subject { paypal.update_recurring_profile }

    it { should be_valid }
    its(:profile_id) { should == "I-6BWVV63V49JT" }
    its(:errors) { should be_empty }
  end

  vcr_options1 = { cassette_name: 'update_profile/profile' }
  context "updated profile", vcr: vcr_options1 do
    #use_vcr_cassette "update_profile/profile"

    let(:paypal) { PaypalExpressCheckout::Recurring.new(:profile_id => "I-6BWVV63V49JT") }
    subject { paypal.profile }

    its(:amount) { should eql("10.00") }
    its(:description) { should eql("Awesome - Monthly Subscription (Updated)") }
  end

  vcr_options2 = { cassette_name: 'update_profile/failure' }
  context "when failure", vcr: vcr_options2 do
    #use_vcr_cassette("update_profile/failure")

    let(:paypal) {
      PaypalExpressCheckout::Recurring.new({
        :profile_id => "I-W4FNTE6EXJ2W",
        :amount     => "10.00"
      })
    }
    subject { paypal.update_recurring_profile }

    it { should_not be_valid }
    its(:errors) { should have(1).items }
  end
end