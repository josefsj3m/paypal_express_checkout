require 'spec_helper'
require 'paypal_express_checkout'

describe PaypalExpressCheckout::Recurring::Response::Profile do
  let(:paypal) {
    PaypalExpressCheckout::Recurring.new({
      :profile_id     => "I-1BASBJ9C9WBS",
      :transaction_id => "4GP25924UB013401J",
      :reference      => "12345",
      :refund_type    => :full,
      :amount         => "9.00",
      :currency       => "BRL"
    })
  }

  vcr_options = { cassette_name: 'refund/success' }
  context "when successful", vcr: vcr_options do
    #use_vcr_cassette "refund/success"
    subject { paypal.refund }

    its(:transaction_id) { should eql("5MM61417CA010574T") }
    its(:fee_amount) { should eql("0.71") }
    its(:gross_amount) { should eql("9.00") }
    its(:net_amount) { should eql("8.29") }
    its(:amount) { should eql("9.00") }
    its(:currency) { should eql("BRL") }
  end

  vcr_options1 = { cassette_name: 'refund/failure' }
  context "when failure", vcr: vcr_options1 do
    #use_vcr_cassette "refund/failure"
    subject { paypal.refund }

    its(:errors) { should have(1).items }
  end
end
