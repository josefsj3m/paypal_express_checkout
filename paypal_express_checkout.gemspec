# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'paypal_express_checkout/version'

Gem::Specification.new do |spec|
  spec.name          = "paypal_express_checkout"
  spec.version       = PaypalExpressCheckout::VERSION
  spec.authors       = ["José Fernando"]
  spec.email         = ["José Fernando <josefsmvm@gmail.com>"]

  spec.description   = %q{PayPal Express Checkout API Client using Paypa's NVP endpoint.}
  spec.summary       = %q{PayPal Express Checkout API Client.}
  spec.homepage      = "https://github.com/josefsj3m/paypal_express_checkout.git"
  spec.license       = "Nonstandard"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://github.com/josefsj3m/paypal_express_checkout.git"
    # Uncomment to build full doc on gem install
    #spec.metadata["yard.run"] = "yri" # use "yard" to build full HTML docs.
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  #spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  #spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }


  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "< 3.0"
  spec.add_development_dependency "yard", "~> 0.9"
  spec.add_development_dependency "vcr", '< 4.0'
  spec.add_development_dependency "fakeweb", '~> 1.3'
  spec.add_development_dependency "pry", '~> 0.10'
  spec.add_development_dependency "awesome_print", '~> 1.7'
  spec.add_development_dependency "activesupport", '~> 5.0'

end
