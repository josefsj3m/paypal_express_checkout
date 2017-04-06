require 'spec_helper'
require 'paypal_express_checkout'

describe PaypalExpressCheckout::Recurring::Response::ManageProfile do
  let(:paypal) { PaypalExpressCheckout::Recurring.new(:profile_id => "I-W4FNTE6EXJ2W") }

  context "suspending" do
    vcr_options = { cassette_name: 'profile/suspend/success' }
    context "when successful", vcr: vcr_options do
      #use_vcr_cassette "profile/suspend/success"
      subject { paypal.suspend }

      it { should be_success }
      it { should be_valid }
    end

    vcr_options1 = { cassette_name: 'profile/suspend/failure' }
    context "when failure", vcr: vcr_options1 do
      #use_vcr_cassette "profile/suspend/failure"
      subject { paypal.suspend }

      it { should_not be_success }
      it { should_not be_valid }
      its(:errors) { should have(1).item }
    end
  end

  context "reactivating" do
    vcr_options2 = { cassette_name: 'profile/reactivate/success' }
    context "when successful", vcr: vcr_options2 do
      #use_vcr_cassette "profile/reactivate/success"
      subject { paypal.reactivate }

      it { should be_success }
      it { should be_valid }
    end

    vcr_options3 = { cassette_name: 'profile/reactivate/failure' }
    context "when failure", vcr: vcr_options3 do
      #use_vcr_cassette "profile/reactivate/failure"
      subject { paypal.reactivate }

      it { should_not be_success }
      it { should_not be_valid }
      its(:errors) { should have(1).item }
    end
  end

  context "cancelling" do
    vcr_options4 = { cassette_name: 'profile/cancel/success' }
    context "when successful", vcr: vcr_options4 do
      #use_vcr_cassette "profile/cancel/success"
      subject { paypal.cancel }

      it { should be_success }
      it { should be_valid }
    end

    vcr_options5 = { cassette_name: 'profile/cancel/failure' }
    context "when failure", vcr: vcr_options5 do
      #use_vcr_cassette "profile/cancel/failure"
      subject { paypal.cancel }

      it { should_not be_success }
      it { should_not be_valid }
      its(:errors) { should have(1).item }
    end
  end
end
