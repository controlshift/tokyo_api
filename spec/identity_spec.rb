require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe TokyoApi::Identity do
  subject { TokyoApi.new(host: 'test.com') }

  describe 'configuration' do
    it 'should propagate the host' do
      expect(subject.identity.client.connection.configuration.host).to eq('test.com')
    end
  end

  describe 'full_user' do
    let(:body) { fixture('responses/full_user_success') }
    let(:request_path) { '/identity/full_user/1' }
    let(:status) { 200 }

    before(:each) do
      stub_get(request_path).to_return(:body => body, :status => status,
                                       :headers => { content_type: "application/json; charset=utf-8"})
    end

    describe 'error' do
      let(:body) { fixture('responses/full_user_error') }

      it 'should return an error hash' do
        expect(subject.identity.full_user('1')).to eq({'error' => 'Connection refused'})
      end
    end

    describe 'success' do
      let(:body) { fixture('responses/identity/full_user_success') }

      it 'should return a hash' do
        expect(subject.identity.full_user('1')).to eq({'first_name' => 'Homer', 'last_name' => 'Simpson',
                                                       'country' => 'GB', 'postal' => '12345', 'email' => 'foo@bar.com' })
      end
    end
  end

  describe 'tokyo_identity_user_path' do
    it 'should return rooted relative path to tokyo user API endpoint' do
      expect(subject.identity.tokyo_identity_user_path('-123456')).to eq('/identity/user/-123456')
    end
  end
end
