require 'spec_helper'

describe 'Yt::URL#resource' do
  before(:all) do
    Yt.configuration.api_key = ENV['YT_SERVER_API_KEY']
    Yt.configuration.client_id = ''
    Yt.configuration.client_secret = ''
  end

  subject(:url) { Yt::URL.new text }

  context 'given an existing YouTube channel URL' do
    let(:text) { 'youtube.com/channel/UCxO1tY8h1AhOz0T4ENwmpow' }

    it {expect(url.resource).to be_a Yt::Channel }
    it {expect(url.resource.title).to be }
  end

  context 'given an existing YouTube video URL' do
    let(:text) { 'youtube.com/watch?v=gknzFj_0vvY' }

    it {expect(url.resource).to be_a Yt::Video }
    it {expect(url.resource.title).to be }
  end

  context 'given an unknown YouTube video URL' do
    let(:text) { 'youtu.be/invalid-id-' }

    it {expect(url.resource).to be_a Yt::Video }
    it {expect{url.resource.title}.to raise_error Yt::Errors::NoItems }
  end

  context 'given an unknown text' do
    let(:text) { 'not-really-anything---' }

    it {expect{url.resource}.to raise_error Yt::Errors::NoItems }
  end

end

