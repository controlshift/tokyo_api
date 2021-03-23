# frozen_string_literal: true

require File.expand_path("#{File.dirname(__FILE__)}/spec_helper")

describe TokyoApi do
  before(:each) do
    allow(TokyoApi::Client).to receive(:setup_client)
  end
  specify { expect(subject).to respond_to :actionkit }
  specify { expect(subject.new).to be_a(TokyoApi::Client) }
end
