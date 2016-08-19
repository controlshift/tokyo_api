# Generated by juwelier
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Juwelier::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: tokyo_api 0.3.0 ruby lib

Gem::Specification.new do |s|
  s.name = "tokyo_api"
  s.version = "0.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Nathan Woodhull"]
  s.date = "2016-08-19"
  s.description = "Tokyo is a CRM middleware, this gem helps apps talk to it."
  s.email = "nathan@controlshiftlabs.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".document",
    ".rspec",
    ".ruby-gemset",
    ".ruby-version",
    ".travis.yml",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "example.rb",
    "lib/tokyo_api.rb",
    "lib/tokyo_api/actionkit.rb",
    "lib/tokyo_api/base.rb",
    "lib/tokyo_api/bluestatedigital.rb",
    "lib/tokyo_api/client.rb",
    "lib/tokyo_api/expire.rb",
    "lib/tokyo_api/krautbuster.rb",
    "spec/actionkit_spec.rb",
    "spec/bluestatedigital_spec.rb",
    "spec/client_spec.rb",
    "spec/expire_spec.rb",
    "spec/fixtures/expire/success",
    "spec/fixtures/responses/full_user_error",
    "spec/fixtures/responses/full_user_success",
    "spec/krautbuster_spec.rb",
    "spec/spec_helper.rb",
    "spec/tokyo_api_spec.rb",
    "tokyo_api.gemspec"
  ]
  s.homepage = "http://github.com/controlshift/tokyo_api"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.8"
  s.summary = "Ruby API Wrapper for Tokyo CRM service"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<vertebrae>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<webmock>, [">= 0"])
      s.add_development_dependency(%q<byebug>, [">= 0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<juwelier>, ["~> 2.1.0"])
    else
      s.add_dependency(%q<vertebrae>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<webmock>, [">= 0"])
      s.add_dependency(%q<byebug>, [">= 0"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<juwelier>, ["~> 2.1.0"])
    end
  else
    s.add_dependency(%q<vertebrae>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<webmock>, [">= 0"])
    s.add_dependency(%q<byebug>, [">= 0"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<juwelier>, ["~> 2.1.0"])
  end
end

