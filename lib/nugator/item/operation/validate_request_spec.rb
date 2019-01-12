require 'spec_helper'

require 'nugator'

RSpec.describe Item::Operation::ValidateRequest do
  let(:instance) { described_class.new }

  let(:id) { nil }
  let(:count) { nil }
  let(:before) { nil }
  let(:since) { nil }
  let(:tags) { nil }
  let(:request) do
    { id: id, count: count, before: before, since: since, tags: tags }
  end

  subject { instance.call(request) }

  context 'with valid params' do
    it 'does not raise with id' do
      request[:id] = [1]

      expect(subject).to be nil
    end

    it 'does not raise with ids' do
      request[:id] = [1, 2]

      expect(subject).to be nil
    end

    it 'does not raise with all params except id' do
      request[:count] = 10
      request[:since] = Time.parse('2000-01-01 00:00:00 UTC')
      request[:before] = Time.parse('2000-01-10 00:00:00 UTC')
      request[:tags] = %w[test_one, test_two]

      expect(subject).to be nil
    end
  end

  context 'with invalid params' do
    let(:id) { [1] }
    it 'fails when passed count' do
      request[:count] = 5

      expect { subject }.to raise_error(Item::Error::InvalidRequest)
    end

    it 'fails when passed before date' do
      request[:before] = Time.now

      expect { subject }.to raise_error(Item::Error::InvalidRequest)
    end

    it 'fails when passed since date' do
      request[:since] = Time.now

      expect { subject }.to raise_error(Item::Error::InvalidRequest)
    end

    it 'fails when passed tags' do
      request[:tags] = %w[Test One]

      expect { subject }.to raise_error(Item::Error::InvalidRequest)
    end
  end

  context 'when count is out of range' do
    it 'fails when count is 0 or less' do
      request[:count] = 0

      expect { subject }.to raise_error Item::Error::InvalidRequest
    end

    it 'fails when count is more than 10' do
      request[:count] = 11

      expect { subject }.to raise_error Item::Error::InvalidRequest
    end
  end
end
