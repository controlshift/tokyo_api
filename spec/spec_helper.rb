$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'webmock/rspec'
require 'tokyo_api'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.include WebMock::API
  config.color = true
  #config.raise_errors_for_deprecations!
end

def stub_get(path)
  stub_tokyo_request(:get, path)
end

def stub_post(path)
  stub_tokyo_request(:post, path)
end

def stub_tokyo_request(method, path)
  prefix = TokyoApi.new.connection.configuration.prefix.to_s
  scheme = TokyoApi.new.connection.configuration.scheme.to_s
  stub_request(method, "#{scheme}://test.com" + prefix + path)
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(File.join(fixture_path, '/', file))
end
