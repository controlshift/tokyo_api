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
    context 'without required_fields' do
      it 'should return rooted relative path to tokyo user API endpoint' do
        expect(subject.identity.tokyo_identity_user_path('-123456')).to eq('/identity/user/-123456')
      end
    end

    context 'with required_fields' do
      it 'should return rooted relative path to tokyo user API endpoint' do
        expect(subject.identity.tokyo_identity_user_path('-123456', required_fields: [:first_name, :last_name, :email, :postal, :phone])).to eq('/identity/user/-123456?required_fields=first_name,last_name,email,postal,phone')
      end

      it 'should url-escape field names with weird characters' do
        expect(subject.identity.tokyo_identity_user_path('-123456', required_fields: ['email', 'fish & chips'])).to eq('/identity/user/-123456?required_fields=email,fish+%26+chips')
      end
    end

    context 'with_subscription_status and associated arguments' do
      it 'should not include query string parameter if argument is missing' do
        expect(subject.identity.tokyo_identity_user_path('123abc456')).not_to match /.+with_subscription_status=.+/
      end

      it 'should not include query string parameter if argument is false' do
        expect(subject.identity.tokyo_identity_user_path('123abc456', with_subscription_status: false)).not_to match /.+with_subscription_status=.+/
      end

      it 'should not include opt_in_public_ids and minimum_consent_level if with_subscription_status is false' do
        tokyo_path = subject.identity.tokyo_identity_user_path('123abc456',
                                                                with_subscription_status: false,
                                                                opt_in_public_ids: ['policy-1.5'],
                                                                minimum_consent_level: 'explicit')

        expect(tokyo_path).not_to match /.+opt_in_public_ids=.+/
        expect(tokyo_path).not_to match /.+minimum_consent_level=.+/
      end

      it 'should include query string parameter if argument is true' do
        expect(subject.identity.tokyo_identity_user_path('123abc456', with_subscription_status: true)).to match /.+with_subscription_status=.+/
      end

      it 'should include opt_in_public_ids and minimum_consent_level if with_subscription_status is true' do
        tokyo_path = subject.identity.tokyo_identity_user_path('123abc456',
                                                                with_subscription_status: true,
                                                                opt_in_public_ids: ['policy-1.5'],
                                                                minimum_consent_level: 'explicit')

        expect(tokyo_path).to match /.+opt_in_public_ids=.+/
        expect(tokyo_path).to match /.+minimum_consent_level=.+/
      end
    end
  end

  describe '#subscription_status_path' do
    it 'should raise if neither param provided' do
      expect { subject.identity.subscription_status_path('abc123') }.to raise_error(RuntimeError)
    end

    it 'should return correct path for a list of public ids' do
      expected_path = '/identity/subscription_status/abc123?opt_in_public_ids=policy-1.5%2Cpolicy-1.6'
      expect(subject.identity.subscription_status_path('abc123', opt_in_public_ids: ['policy-1.5', 'policy-1.6'])).to eq expected_path
    end

    it 'should support minimum_consent_level' do
      expected_path = '/identity/subscription_status/abc123?opt_in_public_ids=policy-1.5&minimum_consent_level=explicit'
      expect(subject.identity.subscription_status_path('abc123', opt_in_public_ids: ['policy-1.5'], minimum_consent_level: 'explicit')).to eq expected_path
    end
  end
end
