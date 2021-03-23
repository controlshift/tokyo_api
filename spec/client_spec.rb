# frozen_string_literal: true

require File.expand_path("#{File.dirname(__FILE__)}/spec_helper")

describe TokyoApi::Client do
  describe 'initialisation' do
    subject { described_class.new(options) }

    context 'with a basic_auth string parameter' do
      let(:options) { { basic_auth: 'login:password' } }

      it 'should set username/password on the configuration' do
        config = subject.connection.configuration
        expect(config.username).to eq 'login'
        expect(config.password).to eq 'password'
      end
    end

    context 'with a timeout' do
      let(:options) { { timeout: 5 } }

      it 'should set the timeout on the faraday options' do
        config = subject.connection.configuration
        expect(config.faraday_options[:request][:timeout]).to eq 5
      end
    end
  end
end
