require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe TokyoApi::Krautbuster do
  subject { TokyoApi.new(host: 'test.com') }

  describe 'configuration' do
    it 'should propagate the host' do
      expect(subject.krautbuster.client.connection.configuration.host).to eq 'test.com'
    end
  end

  describe '#full_user' do
    let(:body) { fixture('responses/full_user_success') }
    let(:request_path) { '/krautbuster/full_user/123abc456' }
    let(:status) { 200 }

    before(:each) do
     stub_get(request_path).to_return(:body => body, :status => status,
                                     :headers => { content_type: "application/json; charset=utf-8"})
    end

    describe 'error' do
      let(:body) { fixture('responses/full_user_error') }

      it 'should return an error message' do
        expect(subject.krautbuster.full_user('123abc456')).to eq({'error' => 'Connection refused'})
      end
    end

    describe 'success' do
      let(:body) { fixture('responses/krautbuster/full_user_success') }

      it 'should find an organisation' do
        expect(subject.krautbuster.full_user('123abc456')).to eq({'first_name' => 'Homer', 'last_name' => 'Simpson',
                                                                  'country' => 'DE', 'postal' => '12345', 'email' => 'foo@bar.com' })
      end
    end
  end

  describe '#subscription_status' do
    let(:client) { double }
    let(:token) { '2134567890abcdef' }

    subject { TokyoApi::Krautbuster.new(client: client) }

    before :each do
      expect(subject).to receive(:subscription_status_path).with(token).and_return("/krautbuster/subscription_status?token=#{token}")
    end

    it 'should perform request on subscription_status_path' do
      expect(client).to receive(:get_request).with("/krautbuster/subscription_status?token=#{token}").and_return(double(body: {subscribed: true}))

      subs_status = subject.subscription_status(token)

      expect(subs_status).to eq({subscribed: true})
    end

    it 'should return nil if tokyo responds with 404' do
      expect(client).to receive(:get_request).with("/krautbuster/subscription_status?token=#{token}").and_raise(Vertebrae::ResponseError.new(404, {method: 'get', url: "/krautbuster/subscription_status?token=#{token}", status: '404', body: 'Not Found'}))

      subs_status = subject.subscription_status(token)

      expect(subs_status).to be_nil
    end

    it 'should raise if tokyo responds with other error code' do
      expect(client).to receive(:get_request).with("/krautbuster/subscription_status?token=#{token}").and_raise(Vertebrae::ResponseError.new(500, {method: 'get', url: "/krautbuster/subscription_status?token=#{token}", status: '500', body: 'Something bad happened'}))

      expect { subject.subscription_status(token) }.to raise_error Vertebrae::ResponseError
    end
  end

  describe '#user_path' do
    it "should return relative path to user API endpoint" do
      expect(subject.krautbuster.user_path('123abc456', 'save-the-trees')).to eq '/krautbuster/user/123abc456?petition_id=save-the-trees'
    end
  end

  describe '#subscription_status_path' do
    subject { TokyoApi::Krautbuster.new }

    it 'should return correct path' do
      expect(subject.subscription_status_path('abc123')).to eq '/krautbuster/subscription_status/abc123'
    end
  end
end
