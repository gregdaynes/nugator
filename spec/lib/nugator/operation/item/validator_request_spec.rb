require 'spec_helper'

require 'nugator'

RSpec.describe Nugator::Operation::Item::ValidateRequest do
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

  subject { instance.call(request) }

  xit 'with valid params'

  context 'with invalid params' do
    let(:id) { [1] }
    it 'fails when passed count' do
      request[:count] = 5

      expect { subject }.to raise_error(Nugator::Error::InvalidRequest)
    end

    it 'fails when passed before date' do
      request[:before] = Time.now

      expect { subject }.to raise_error(Nugator::Error::InvalidRequest)
    end

    it 'fails when passed since date' do
      request[:since] = Time.now

      expect { subject }.to raise_error(Nugator::Error::InvalidRequest)
    end

    it 'fails when passed tags' do
      request[:tags] = %w[Test One]

      expect { subject }.to raise_error(Nugator::Error::InvalidRequest)
    end
  end

  context 'when count is out of range' do
    it 'fails when count is 0 or less' do
      request[:count] = 0

      expect { subject }.to raise_error Nugator::Error::InvalidRequest
    end

    it 'fails when count is more than 10' do
      request[:count] = 11

      expect { subject }.to raise_error Nugator::Error::InvalidRequest
    end
  end
end
