# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'seo_attachment/version'

Gem::Specification.new do |gem|
  gem.name          = "seo_attachment"
  gem.version       = SeoAttachment::VERSION
  gem.authors       = ["Andrey"]
  gem.email         = ["railscode@gmail.com"]
  gem.description   = "Seo-оптимизированные аттачменты (Paperclip)"
  gem.summary       = "Кого?"
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
