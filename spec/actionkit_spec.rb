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

      it 'should return an error hash' do
        expect(subject.actionkit.full_user('1')).to eq({'error' => 'Connection refused'})
      end
    end

    describe 'success' do
      let(:body) { fixture('responses/actionkit/full_user_success') }

      it 'should return a user message' do
        expect(subject.actionkit.full_user('1')).to eq({ 'first_name' => 'Homer', 'last_name' => 'Simpson',
                                                         'city' => 'Springfield', 'state' => 'YZ', 'country' => 'US',
                                                         'extra_field' => 'hidden extra field', 'email' => 'foo@bar.com' })
      end
    end

    describe 'user_path' do
      context 'phone not required' do
        it "should return relative path to user API endpoint" do
          expect(subject.actionkit.user_path('abc.123.xyz', false)).to eq('/actionkit/user/abc.123.xyz?phone_required=false')
        end
      end

      context 'phone required' do
        it "should return relative path to user API endpoint" do
          expect(subject.actionkit.user_path('abc.123.xyz', true)).to eq('/actionkit/user/abc.123.xyz?phone_required=true')
        end
      end
    end
  end
end
