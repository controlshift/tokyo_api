require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe TokyoApi::Krautbuster do
  subject { TokyoApi.new(host: 'test.com') }

  describe 'configuration' do
    it 'should propagate the host' do
      expect(subject.krautbuster.client.connection.configuration.host).to eq 'test.com'
    end
  end

  describe 'full_user' do
    let(:body) { fixture('responses/full_user_success') }
    let(:request_path) { '/krautbuster/full_user/123abc456' }
    let(:status) { 200 }

    before(:each) do
     stub_get(request_path).to_return(:body => body, :status => status,
                                     :headers => { content_type: "application/json; charset=utf-8"})
    end

    describe 'error' do
      let(:body) { fixture('responses/full_user_error') }

      it 'should find an organisation' do
        expect(subject.krautbuster.full_user('123abc456')).to eq({'error' => 'Connection refused'})
      end
    end

    describe 'error' do
      let(:body) { fixture('responses/full_user_success') }

      it 'should find an organisation' do
        expect(subject.krautbuster.full_user('123abc456')).to be_nil
      end
    end
  end

  describe 'user_path' do
    it "should return relative path to user API endpoint" do
      expect(subject.krautbuster.user_path('123abc456')).to eq '/krautbuster/user/123abc456'
    end
  end
end
