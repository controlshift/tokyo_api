require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe TokyoApi::Campact do
  subject { TokyoApi.new(host: 'test.com') }

  describe 'configuration' do
    it 'should propagate the host' do
      expect(subject.campact.client.connection.configuration.host).to eq 'test.com'
    end
  end

  describe '#full_user' do
    let(:body) { fixture('responses/full_user_success') }
    let(:request_path) { '/campact/full_user/123abc456' }
    let(:status) { 200 }

    before(:each) do
     stub_get(request_path).to_return(:body => body, :status => status,
                                     :headers => { content_type: "application/json; charset=utf-8"})
    end

    describe 'error' do
      let(:body) { fixture('responses/full_user_error') }

      it 'should return an error message' do
        expect(subject.campact.full_user('123abc456')).to eq({'error' => 'Connection refused'})
      end
    end

    describe 'success' do
      let(:body) { fixture('responses/campact/full_user_success') }

      it 'should find an organisation' do
        expect(subject.campact.full_user('123abc456')).to eq({'first_name' => 'Homer', 'last_name' => 'Simpson',
                                                                  'country' => 'DE', 'postal' => '12345', 'email' => 'foo@bar.com' })
      end
    end
  end

  describe '#subscription_status' do
    let(:client) { double }
    let(:token) { '2134567890abcdef' }

    subject { TokyoApi::Campact.new(client: client) }

    before :each do
      expect(subject).to receive(:subscription_status_path).with(token).and_return("/campact/subscription_status?token=#{token}")
    end

    it 'should perform request on subscription_status_path' do
      expect(client).to receive(:get_request).with("/campact/subscription_status?token=#{token}").and_return(double(body: {subscribed: true}))

      subs_status = subject.subscription_status(token)

      expect(subs_status).to eq({subscribed: true})
    end

    it 'should return nil if tokyo responds with 404' do
      expect(client).to receive(:get_request).with("/campact/subscription_status?token=#{token}").and_raise(Vertebrae::ResponseError.new(404, {method: 'get', url: "/campact/subscription_status?token=#{token}", status: '404', body: 'Not Found'}))

      subs_status = subject.subscription_status(token)

      expect(subs_status).to be_nil
    end

    it 'should raise if tokyo responds with other error code' do
      expect(client).to receive(:get_request).with("/campact/subscription_status?token=#{token}").and_raise(Vertebrae::ResponseError.new(500, {method: 'get', url: "/campact/subscription_status?token=#{token}", status: '500', body: 'Something bad happened'}))

      expect { subject.subscription_status(token) }.to raise_error Vertebrae::ResponseError
    end
  end

  describe '#user_path' do
    context 'without required_fields' do
      it "should return relative path to user API endpoint" do
        expect(subject.campact.user_path('123abc456', petition_id: 'save-the-trees')).to eq '/campact/user/123abc456?petition_id=save-the-trees'
      end
    end

    context 'with required_fields' do
      it "should return relative path to user API endpoint" do
        expect(subject.campact.user_path('123abc456', petition_id: 'save-the-trees', required_fields: [:first_name, :last_name, :email])).to eq '/campact/user/123abc456?petition_id=save-the-trees&required_fields=first_name,last_name,email'
      end

      it 'should url-escape field names with weird characters' do
        expect(subject.campact.user_path('123abc456', petition_id: 'save-the-trees', required_fields: ['email', 'fish & chips'])).to eq '/campact/user/123abc456?petition_id=save-the-trees&required_fields=email,fish+%26+chips'
      end
    end

    context 'with_subscription_status argument' do
      it 'should not include query string parameter if argument is missing' do
        expect(subject.campact.user_path('123abc456', petition_id: 'save-the-trees')).not_to match /.+with_subscription_status=.+/
      end

      it 'should not include query string parameter if argument is false' do
        expect(subject.campact.user_path('123abc456', petition_id: 'save-the-trees', with_subscription_status: false)).not_to match /.+with_subscription_status=.+/
      end

      it 'should include query string parameter if argument is true' do
        expect(subject.campact.user_path('123abc456', petition_id: 'save-the-trees', with_subscription_status: true)).to match /.+with_subscription_status=true.*/
      end
    end
  end

  describe '#subscription_status_path' do
    subject { TokyoApi::Campact.new }

    it 'should return correct path' do
      expect(subject.subscription_status_path('abc123')).to eq '/campact/subscription_status/abc123'
    end
  end

  describe '#session_status' do
    let(:client) { double }
    let(:session_id) { '123456789abcdef' }

    subject { TokyoApi::Campact.new(client: client) }

    it 'should perform request on session status path' do
      expect(client).to receive(:get_request).with("/campact/session/#{session_id}/status").and_return(double(body: { hard_login: false, soft_login: true }))

      session_status = subject.session_status(session_id)

      expect(session_status).to eq({ hard_login: false, soft_login: true })
    end
  end

  describe '#destroy_session' do
    let(:client) { double }
    let(:session_id) { '123456789abcdef' }

    subject { TokyoApi::Campact.new(client: client) }

    it 'should perform request on session status path' do
      expect(client).to receive(:delete_request).with("/campact/session/#{session_id}").and_return(double(status: 204))

      result = subject.destroy_session(session_id)

      expect(result).to be_truthy
    end

    it 'should return false if response status is 404' do
      expect(client).to receive(:delete_request).with("/campact/session/#{session_id}").and_return(double(status: 404))

      result = subject.destroy_session(session_id)

      expect(result).to be_falsey
    end
  end
end
