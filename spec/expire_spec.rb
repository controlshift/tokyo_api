require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe TokyoApi::Expire do
  subject { TokyoApi.new(host: 'test.com') }

  describe 'expire organisation' do
    let(:body) { fixture('expire/success') }
    let(:request_path) { '/expire/organisation/foo.com' }

    before(:each) do
     stub_get(request_path).to_return(:body => body, :status => status,
                                     :headers => { content_type: "application/json; charset=utf-8"})
    end

    describe 'success' do
      let(:status) { 200 }  

      it 'should find an organisation' do
        subject.expire.organisation('foo.com').should == {'status' => 'success'}
      end
    end
  end
end