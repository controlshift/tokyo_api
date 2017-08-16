require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe TokyoApi::Bluestatedigital do
  subject { TokyoApi.new(host: 'test.com') }

  describe 'configuration' do
    it 'should propagate the host' do
      expect(subject.bluestatedigital.client.connection.configuration.host).to eq('test.com')
    end
  end

  describe 'full_user' do
    let(:body) { fixture('responses/full_user_success') }
    let(:request_path) { '/bluestatedigital/full_user/1' }
    let(:status) { 200 }

    before(:each) do
      stub_get(request_path).to_return(:body => body, :status => status,
                                       :headers => { content_type: "application/json; charset=utf-8"})
    end

    describe 'error' do
      let(:body) { fixture('responses/full_user_error') }

      it 'should return an error message' do
        expect(subject.bluestatedigital.full_user('1')).to eq({'error' => 'Connection refused'})
      end
    end

    describe 'success' do
      let(:body) { fixture('responses/bluestatedigital/full_user_success') }

      it 'should return a success hash' do
        expect(subject.bluestatedigital.full_user('1')).to eq({ 'first_name' => 'Homer', 'last_name' => 'Simpson',
                                                                'city' => 'Springfield', 'state' => 'YZ', 'country' => 'US',
                                                                'postal' => '12345', 'email' => 'foo@bar.com' })
      end
    end
  end

  describe 'tokyo_blue_state_digital_user_path' do
    context 'phone not required' do
      it "should return rooted relative path to tokyo user API endpoint" do
        expect(subject.bluestatedigital.tokyo_blue_state_digital_user_path('-123456', false)).to eq('/bluestatedigital/constituent/-123456?phone_required=false')
      end
    end

    context 'phone required' do
      it "should return rooted relative path to tokyo user API endpoint" do
        expect(subject.bluestatedigital.tokyo_blue_state_digital_user_path('-123456', true)).to eq('/bluestatedigital/constituent/-123456?phone_required=true')
      end
    end
  end
end
