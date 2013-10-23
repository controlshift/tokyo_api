require 'vertebrae'
require 'tokyo_api/base'
require 'tokyo_api/actionkit'
require 'tokyo_api/expire'
require 'tokyo_api/client'

module TokyoApi
  extend Vertebrae::Base

  class << self
    def new(options = {}, &block)
      TokyoApi::Client.new(options, &block)
    end
  end
end