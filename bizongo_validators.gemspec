
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "bizongo_validators/version"

Gem::Specification.new do |spec|
  spec.name          = "bizongo_validators"
  spec.version       = BizongoValidators::VERSION
  spec.authors       = ["Anuj Khandelwal"]
  spec.email         = ["khandelwal.anuj14@gmail.com"]

  spec.summary       = %q{Contains modules that can be used to validate certain fields in a model.}
  spec.description   = %q{This gem contains modules that act as validators for contact number and email}
  spec.homepage      = "https://bizongo.in" # Put your gem's website or public repo URL here.

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "Set to 'http://mygemserver.com'"
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

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "active_record"
  spec.add_development_dependency "active_support"  
end
