module PaypalExpressCheckout
  module Recurring
    module Response
      autoload :Base, 'paypal_express_checkout/recurring/response/base'
      autoload :Checkout, 'paypal_express_checkout/recurring/response/checkout'
      autoload :Details, 'paypal_express_checkout/recurring/response/details'
      autoload :Payment, 'paypal_express_checkout/recurring/response/payment'
      autoload :ManageProfile, 'paypal_express_checkout/recurring/response/manage_profile'
      autoload :Profile, 'paypal_express_checkout/recurring/response/profile'
      autoload :Refund, 'paypal_express_checkout/recurring/response/refund'

      RESPONDERS = {
          :checkout       => 'Checkout',
          :details        => 'Details',
          :payment        => 'Payment',
          :profile        => 'Profile',
          :create_profile => 'ManageProfile',
          :manage_profile => 'ManageProfile',
          :update_profile => 'ManageProfile',
          :refund         => 'Refund'
      }

      def self.process(method, response)
        response_class = PaypalExpressCheckout::Recurring::Response.const_get(RESPONDERS[method])
        response_class.new(response)
      end
    end
  end
end