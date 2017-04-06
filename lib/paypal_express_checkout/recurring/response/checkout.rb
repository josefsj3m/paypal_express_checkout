module PaypalExpressCheckout
  module Recurring
    module Response
      class Checkout < Base
        def checkout_url
          "#{PaypalExpressCheckout::Recurring.site_endpoint}?cmd=_express-checkout&token=#{token}&useraction=commit"
        end
      end
    end
  end
end
