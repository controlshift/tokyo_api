require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe TokyoApi do
  before(:each) do
    TokyoApi::Client.stub(:setup_client)
  end
  specify { subject.should respond_to :actionkit }
  specify { subject.new.should be_a(TokyoApi::Client)}
end


