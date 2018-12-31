require 'spec_helper'
require 'time'

require 'dry/container/stub'

require 'nugator'

RSpec.describe Nugator::Operation::Item::FetchItem do
  let!(:item_repository) { Persistance::Item.new }

  let(:instance) { described_class.new }
  let(:id) { nil }
  let(:request) do
    {
      id: id,
      content: false,
      count: nil,
      before: nil,
      since: nil
    }
  end

  before do
    Nugator::Container.enable_stubs!
    Nugator::Container.stub('repository.item', item_repository)
  end

  subject { instance.call(request) }

  context 'when request for items by id' do
    context 'with single id' do
      let(:id) { [1] }

      it 'returns an item by id' do
        item = subject.first

        expect(subject).to be_a Array
        expect(subject.count).to be 1

        expect(item.id).to eq 1
        expect(item.author).to eq 'Testy McTesterson'
        expect(item.title).to eq 'Test Title 1'
        expect(item.link).to eq 'https://example.com'
        expect(item.excerpt).to eq 'Test Excerpt'
      end
    end

    context 'when request for items by id' do
      context 'with single id' do
        it 'returns items' do
          request[:id] = [1, 2]

          items = subject

          expect(items.first.id).to eq(1 || 2)
          expect(items.count).to eq 2
        end

        it 'returns found items only' do
          request[:id] = [1, 2, 666]

          expect(subject.count).to eq 2
        end

        it 'fails when cannot find item by id' do
          request[:id] = [666]

          expect(subject.empty?).to be true
        end
      end

      context 'when request for count' do
        let(:id) { nil }

        it 'returns items equal to count' do
          request[:count] = 2

          expect(subject.count).to be 2
        end

        it 'returns less items when found items are less than count' do
          request[:count] = 2

          expect(subject.count).to be 2
        end

        it 'does not return more items than count' do
          request[:count] = 1

          expect(subject.count).to be 1
        end
      end
    end

    context 'when request for items since datetime' do
      let(:id) { nil }

      it 'returns items' do
        request[:since] = Time.parse('2000-01-01 00:00:00 UTC')

        expect(subject.count).to be 11
      end

      it 'does not return items before date' do
        request[:since] = Time.parse('2000-01-02 00:00:00 UTC')

        item_dates = subject.map(&:published_date)

        expect(item_dates.include?('2000-01-01 00:00:00 UTC')).to be false
      end
    end

    context 'when request for items before datetime' do
      let(:id) { nil }

      it 'returns items' do
        request[:before] = Time.parse('2000-01-02 00:00:00 UTC')

        expect(subject.count).to be 2
      end

      it 'does not return items after date' do
        request[:before] = Time.parse('2000-01-08 00:00:00 UTC')

        item_dates = subject.map(&:published_date)

        expect(item_dates.include?('2000-01-09 00:00:00 UTC')).to be false
      end
    end

    context 'when request for tags' do
      let(:id) { nil }

      it 'returns items for tag' do
        request[:tags] = %w[test_item]

        expect(subject.count).to be 10
      end

      it 'returns items that has at least one tag in tags' do
        request[:tags] = %w[test_tag_1]

        expect(subject.count).to be 1
      end

      it 'does not return items without tag' do
        request[:tags] = %w[test_tag_1]

        expect(subject.count).to be 1
      end
    end

    context 'when request is multiple lookups' do
      let(:id) { nil }

      it 'returns results for tags and since' do
        request[:since] = Time.parse('2000-01-07 00:00:00 UTC')
        request[:tags] = %w[test_item]

        expect(subject.count).to be 4
      end

      it 'returns results for tags and before' do
        request[:before] = Time.parse('2000-01-08 00:00:00 UTC')
        request[:tags] = %w[test_tag_7]

        expect(subject.count).to be 1
      end

      it 'returns results for tags and count' do
        request[:tags] = %w[test_item]
        request[:count] = 3

        expect(subject.count).to be 3
      end

      it 'returns results for tags in date range' do
        request[:since] = Time.parse('2000-01-04 00:00:00 UTC')
        request[:before] = Time.parse('2000-01-08 00:00:00 UTC')
        request[:tags] = %w[test_item test_tag_7]

        expect(subject.count).to be 5
      end

      it 'returns results for date range' do
        request[:since] = Time.parse('2000-01-04 00:00:00 UTC')
        request[:before] = Time.parse('2000-01-08 00:00:00 UTC')

        item_dates = subject.map(&:published_date)

        expect(subject.count).to be 5
        expect(item_dates.include?('2000-01-04 00:00:00 UTC')).to be true
        expect(item_dates.include?('2000-01-06 00:00:00 UTC')).to be true
        expect(item_dates.include?('2000-01-08 00:00:00 UTC')).to be true

        expect(item_dates.include?('2000-01-03 00:00:00 UTC')).to be false
        expect(item_dates.include?('2000-01-09 00:00:00 UTC')).to be false
      end

      it 'returns items if before and since are reversed' do
        request[:before] = Time.parse('2000-01-04 00:00:00 UTC')
        request[:since] = Time.parse('2000-01-08 00:00:00 UTC')

        item_dates = subject.map(&:published_date)

        expect(subject.count).to be 5
        expect(item_dates.include?('2000-01-04 00:00:00 UTC')).to be true
        expect(item_dates.include?('2000-01-06 00:00:00 UTC')).to be true
        expect(item_dates.include?('2000-01-08 00:00:00 UTC')).to be true

        expect(item_dates.include?('2000-01-03 00:00:00 UTC')).to be false
        expect(item_dates.include?('2000-01-09 00:00:00 UTC')).to be false
      end

      it 'returns results for date range limited by count' do
        request[:since] = Time.parse('2000-01-04 00:00:00 UTC')
        request[:before] = Time.parse('2000-01-08 00:00:00 UTC')
        request[:count] = 3

        expect(subject.count).to be 3
      end
    end
  end
end
