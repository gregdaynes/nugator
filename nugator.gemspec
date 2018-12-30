
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nugator/version'

Gem::Specification.new do |spec|
  spec.name          = 'nugator'
  spec.version       = Nugator::VERSION
  spec.authors       = ['Gregory Daynes']
  spec.email         = ['gregdaynes@gmail.com']

  spec.summary       = 'A general feed reader and parser'
  spec.description   = 'needs a better description'
  spec.homepage      = 'https://github.com/gregdaynes/nugator'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'simplecov'

  spec.add_dependency 'dry-auto_inject'
  spec.add_dependency 'dry-container'
  spec.add_dependency 'dry-struct'
end