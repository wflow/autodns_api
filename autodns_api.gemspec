# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'autodns_api/version'

Gem::Specification.new do |spec|
  spec.name          = 'autodns_api'
  spec.version       = AutodnsAPI::VERSION.dup
  spec.authors       = ['Florian Aman', 'Thomas Steinhausen']
  spec.email         = ['support@webflow.de']

  spec.summary       = 'AutoDNS API client.'
  spec.description   = 'Ruby client for the InterNetX AutoDNS XML API'
  spec.homepage      = 'https://github.com/wflow/autodns_api'
  spec.license       = 'MIT'

  spec.files         = Dir['{lib}/**/*']
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'nokogiri'
  spec.add_runtime_dependency 'faraday'

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'pry'
end