# frozen_string_literal: true

require 'vertebrae'
require 'tokyo_api/base'
require 'tokyo_api/actionkit'
require 'tokyo_api/bluestatedigital'
require 'tokyo_api/campact'
require 'tokyo_api/client'
require 'tokyo_api/expire'
require 'tokyo_api/identity'

module TokyoApi
  extend Vertebrae::Base

  class << self
    def new(options = {}, &block)
      TokyoApi::Client.new(options, &block)
    end
  end
end
