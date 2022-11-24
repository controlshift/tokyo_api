# frozen_string_literal: true

require File.expand_path("#{File.dirname(__FILE__)}/spec_helper")

describe TokyoApi::ExternalImage do
  subject { TokyoApi.new(host: 'test.com') }

  describe '#track_download' do
    let(:photo_id) { 'abcde-123456' }
    let(:request_path) { "/external_image/#{photo_id}/download" }

    before(:each) do
      stub_post(request_path).to_return(body: body, status: status,
                                       headers: { content_type: 'application/json; charset=utf-8' })
    end

    context 'error on tokyo' do
      let(:status) { 500 }
      let(:body) { {status: :error}.to_json }

      it 'should raise error' do
        expect { subject.external_image.track_download(photo_id) }.to raise_error(Vertebrae::ResponseError)
      end
    end

    context 'successful call to tokyo' do
      let(:status) { 204 }
      let(:body) { nil }

      it 'should return true' do
        result = subject.external_image.track_download(photo_id)

        expect(result).to be_truthy
      end
    end
  end
end
