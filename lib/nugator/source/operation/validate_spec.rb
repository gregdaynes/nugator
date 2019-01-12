require 'spec_helper'

require 'nugator'

RSpec.describe Source::Operation::Validate do
  let(:instance) { described_class.new }

  let(:url) { nil }
  let(:source) do
    {
      url: url
    }
  end

  subject { instance.call(source) }

  it 'raises when url not provided' do
    expect { subject }.to raise_error Source::Error::InvalidRequest
  end
end
