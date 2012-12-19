# encoding: utf-8
require File.expand_path('../lib/myfonts/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Artem Shitov"]
  gem.email         = ["inbox@artemshitov.ru"]
  gem.summary       = "Ruby interface to MyFonts"
  gem.homepage      = "https://github.com/artemshitov/myfonts"
  gem.description   = "Gem allows to fetch info about fonts hosted on MyFonts"

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "webmock"
  gem.add_development_dependency "vcr"

  gem.add_dependency "httparty"
  gem.add_dependency "nokogiri"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "MyFonts"
  gem.require_paths = ["lib"]
  gem.version       = MyFonts::VERSION
end