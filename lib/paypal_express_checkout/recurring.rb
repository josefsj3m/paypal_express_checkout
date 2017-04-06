require 'net/https'
require 'cgi'
require 'uri'
require 'ostruct'
require 'time'

module PaypalExpressCheckout
  module Recurring
    autoload :Base, "paypal_express_checkout/recurring/base"
    autoload :Notification, "paypal_express_checkout/recurring/notification"
    autoload :Request, "paypal_express_checkout/recurring/request"
    autoload :Response, "paypal_express_checkout/recurring/response"
    autoload :Version, "paypal_express_checkout/version"
    autoload :Utils, "paypal_express_checkout/recurring/utils"

    ENDPOINTS = {
        :sandbox => {
            :api  => "https://api-3t.sandbox.paypal.com/nvp",
            :site => "https://www.sandbox.paypal.com/cgi-bin/webscr"
        },
        :production => {
            :api  => "https://api-3t.paypal.com/nvp",
            :site => "https://www.paypal.com/cgi-bin/webscr"
        }
    }

    class << self
      # Define if requests should be made to PayPal's
      # sandbox environment. This is specially useful when running
      # on development or test mode.
      #
      #   PayPalExpressCheckout::Recurring.sandbox = true
      #
      attr_accessor :sandbox

      # Set PayPal's API username.
      #
      attr_accessor :username

      # Set PayPal's API password.
      #
      attr_accessor :password

      # Set PayPal's API signature.
      #
      attr_accessor :signature

      # Set seller id. Will be used to verify IPN.
      #
      #
      attr_accessor :seller_id

      # The seller e-mail. Will be used to verify IPN.
      #
      attr_accessor :email
    end

    # Just a shortcut for <tt>PayPal::Recurring::Base.new</tt>.
    #
    def self.new(options = {})
      Base.new(options)
    end

    # Configure PayPalExpressCheckout::Recurring options.
    #
    #   PayPalExpressCheckout::Recurring.configure do |config|
    #     config.sandbox = true
    #   end
    #
    def self.configure(&block)
      yield PaypalExpressCheckout::Recurring
    end

    # Detect if sandbox mode is enabled.
    #
    def self.sandbox?
      sandbox == true
    end

    # Return a name for current environment mode (sandbox or production).
    #
    def self.environment
      sandbox? ? :sandbox : :production
    end

    # Return URL endpoints for current environment.
    #
    def self.endpoints
      ENDPOINTS[environment]
    end

    # Return API endpoint based on current environment.
    #
    def self.api_endpoint
      endpoints[:api]
    end

    # Return PayPal's API version. This version was released on March, 30, 2016.
    #
    def self.api_version
      "204.0"
    end

    # Return site endpoint based on current environment.
    #
    def self.site_endpoint
      endpoints[:site]
    end
  end
end