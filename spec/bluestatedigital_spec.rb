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

      it 'should find an organisation' do
        expect(subject.bluestatedigital.full_user('1')).to eq({'error' => 'Connection refused'})
      end
    end

    describe 'error' do
      let(:body) { fixture('responses/full_user_success') } #TODO: actually figure out what this returns.

      it 'should find an organisation' do
        expect(subject.bluestatedigital.full_user('1')).to eq(nil)
      end
    end
  end

  describe 'tokyo_blue_state_digital_user_path' do
    it "should return rooted relative path to tokyo user API endpoint" do
      expect(subject.bluestatedigital.tokyo_blue_state_digital_user_path('-123456')).to eq('/bluestatedigital/constituent/-123456')
    end
  end
end
