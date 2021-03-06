# Generated by juwelier
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Juwelier::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: tokyo_api 1.6.0 ruby lib

Gem::Specification.new do |s|
  s.name = "tokyo_api".freeze
  s.version = "1.6.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Nathan Woodhull".freeze]
  s.date = "2021-03-24"
  s.description = "Tokyo is a CRM middleware, this gem helps apps talk to it.".freeze
  s.email = "nathan@controlshiftlabs.com".freeze
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
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "example.rb",
    "lib/tokyo_api.rb",
    "lib/tokyo_api/actionkit.rb",
    "lib/tokyo_api/base.rb",
    "lib/tokyo_api/campact.rb",
    "lib/tokyo_api/client.rb",
    "lib/tokyo_api/expire.rb",
    "lib/tokyo_api/identity.rb",
    "spec/actionkit_spec.rb",
    "spec/campact_spec.rb",
    "spec/client_spec.rb",
    "spec/expire_spec.rb",
    "spec/fixtures/expire/success",
    "spec/fixtures/responses/actionkit/full_user_success",
    "spec/fixtures/responses/campact/full_user_success",
    "spec/fixtures/responses/full_user_error",
    "spec/fixtures/responses/full_user_success",
    "spec/fixtures/responses/identity/full_user_success",
    "spec/fixtures/responses/krautbuster/full_user_success",
    "spec/identity_spec.rb",
    "spec/spec_helper.rb",
    "spec/tokyo_api_spec.rb",
    "tokyo_api.gemspec"
  ]
  s.homepage = "http://github.com/controlshift/tokyo_api".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.8".freeze
  s.summary = "Ruby API Wrapper for Tokyo CRM service".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<vertebrae>.freeze, [">= 0.6.0"])
      s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_development_dependency(%q<byebug>.freeze, [">= 0"])
      s.add_development_dependency(%q<juwelier>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_development_dependency(%q<rubocop>.freeze, [">= 0"])
      s.add_development_dependency(%q<webmock>.freeze, [">= 0"])
    else
      s.add_dependency(%q<vertebrae>.freeze, [">= 0.6.0"])
      s.add_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_dependency(%q<byebug>.freeze, [">= 0"])
      s.add_dependency(%q<juwelier>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_dependency(%q<rubocop>.freeze, [">= 0"])
      s.add_dependency(%q<webmock>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<vertebrae>.freeze, [">= 0.6.0"])
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<byebug>.freeze, [">= 0"])
    s.add_dependency(%q<juwelier>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<rubocop>.freeze, [">= 0"])
    s.add_dependency(%q<webmock>.freeze, [">= 0"])
  end
end

