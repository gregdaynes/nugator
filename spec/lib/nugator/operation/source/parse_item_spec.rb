require 'spec_helper'

require 'nugator'

RSpec.describe Nugator::Operation::Source::ParseItem do
  let(:instance) { described_class.new }
  let(:raw_source_item) do
    Marshal.load("\x04\bo:\x1CRSS::Rss::Channel::Item-:\f@parent0:\x0F@converter0:\x11@do_validateF:\v@titleI\"4Former top-100 pro golfer arrested for poaching\x06:\x06ET:\n@linkI\"ahttps://www.golfchannel.com/news/former-top-100-pro-golfer-jyoti-randhawa-arrested-poaching/\x06;\nT:\x11@descriptionI\"\x01\x8FJyoti Randhawa, who at one point was ranked top 100 in the world, was arrested Wednesday for alleged poaching at Dudhwa Tiger Reserve in India.\x06;\nT:\f@source0:\x0F@enclosure0:\x0E@commentsI\"jhttps://www.golfchannel.com/news/former-top-100-pro-golfer-jyoti-randhawa-arrested-poaching/#comments\x06;\nT:\f@authorI\"\x10Some Author\x06;\nT:\r@pubDateIu:\tTime\rL\xAF\x1D\xC0\x00\x00\x00\xD4\x06:\tzoneI\"\bUTC\x06;\nF:\n@guido:\"RSS::Rss::Channel::Item::Guid\n;\x060;\a0;\bF:\x11@isPermaLinkF:\r@contentI\"ahttps://www.golfchannel.com/news/former-top-100-pro-golfer-jyoti-randhawa-arrested-poaching/\x06;\nT:\x15@content_encoded0:\x13@itunes_author0:\x12@itunes_block0:\x15@itunes_explicit0:\x15@itunes_keywords0:\x15@itunes_subtitle0:\x14@itunes_summary0:\x11@itunes_name0:\x12@itunes_email0:\x15@itunes_duration0:\x14@trackback_ping0:\x0E@category[\x00:\x0E@dc_title[\x00:\x14@dc_description[\x00:\x10@dc_creator[\x00:\x10@dc_subject[\x00:\x12@dc_publisher[\x00:\x14@dc_contributor[\x00:\r@dc_type[\x00:\x0F@dc_format[\x00:\x13@dc_identifier[\x00:\x0F@dc_source[\x00:\x11@dc_language[\x00:\x11@dc_relation[\x00:\x11@dc_coverage[\x00:\x0F@dc_rights[\x00:\r@dc_date[\x00:\x15@trackback_about[\x00")
  end
  let(:source_item) { raw_source_item }

  subject { instance.call(source_item) }

  it 'converts raw source item into a structured item' do
    expect(subject).to be_a(OpenStruct)
    expect(subject.author).to be_a(String)
    expect(subject.published_date).to be_a(DateTime)
    expect(subject.content).to be_a(String)
    expect(subject.title).to be_a(String)
    expect(subject.link).to be_a(String)
  end

  describe 'author' do
    context 'when source item author is not defined' do
      let(:source_item) {
        raw_source_item.tap do |i|
          i.author = nil
          i.dc_creator = 'Some Creator'
        end
      }

      it 'uses dc_creator as author' do
        expect(subject.author).to eq 'Some Creator'
      end
    end

    context 'when source item author and dc_creator is not defined' do
      let(:source_item) {
        raw_source_item.tap do |i|
          i.author = nil
          i.dc_creator = nil
        end
      }

      it 'uses nil as author' do
        expect(subject.author).to eq nil
      end
    end
  end

  describe 'published_date' do
    context 'when published_date is parsable' do
      it 'is a DateTime' do
        expect(subject.published_date.to_s).to eq '2018-12-26T12:53:00+00:00'
      end
    end

    context 'when published_date is unparsable' do
      before do
        stubbed_time = Time.now
        allow(Time).to receive(:now).and_return(stubbed_time)
      end

      let(:source_item) {
        raw_source_item.tap do |i|
          i.pubDate = nil
        end
      }

      it 'is now' do
        expect(subject.published_date).to eq Time.now
      end
    end
  end
end
