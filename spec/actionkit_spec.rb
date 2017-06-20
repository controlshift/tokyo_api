require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe TokyoApi::Actionkit do
  subject { TokyoApi.new(host: 'test.com') }

  describe 'configuration' do
    it 'should propagate the host' do
      expect(subject.actionkit.client.connection.configuration.host).to eq('test.com')
    end
  end

  describe 'full_user' do
    let(:body) { fixture('responses/full_user_success') }
    let(:request_path) { '/actionkit/full_user/1' }
    let(:status) { 200 }

    before(:each) do
     stub_get(request_path).to_return(:body => body, :status => status,
                                     :headers => { content_type: "application/json; charset=utf-8"})
    end

    describe 'error' do
      let(:body) { fixture('responses/full_user_error') }

      it 'should find an organisation' do
        expect(subject.actionkit.full_user('1')).to eq({'error' => 'Connection refused'})
      end
    end

    describe 'error' do
      let(:body) { fixture('responses/full_user_success') } #TODO: actually figure out what this returns.

      it 'should find an organisation' do
        expect(subject.actionkit.full_user('1')).to eq(nil)
      end
    end

    describe 'user_path' do
      it "should return relative path to user API endpoint" do
        expect(subject.actionkit.user_path('abc.123.xyz')).to eq('/actionkit/user/abc.123.xyz')
      end
    end
  end
end
