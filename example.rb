# frozen_string_literal: true

$LOAD_PATH << File.join(File.dirname(__FILE__), 'lib')

require 'tokyo_api'

ta = TokyoApi.new(host: 'localhost:9000', username: 'tokyo', password: 'Passw0rd!', scheme: 'http')

require 'pry-debugger'
binding.pry
