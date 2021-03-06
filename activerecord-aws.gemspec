
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "active_record/aws/version"

Gem::Specification.new do |spec|
  spec.name          = "activerecord-aws"
  spec.version       = ActiveRecord::Aws::VERSION
  spec.authors       = ["Alexander Mancevice"]
  spec.email         = ["alexander.mancevice@gmail.com"]

  spec.summary       = "Helper for using AWS with ActiveRecord."
  spec.description   = "Helper for using AWS with ActiveRecord."
  spec.homepage      = "https://github.com/amancevice/activerecord-aws"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
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
end
