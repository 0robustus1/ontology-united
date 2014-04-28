require 'spec_helper'

describe OntologyUnited::DSL::OntologyPrefix do

  context '#class' do
    let(:prefix) { described_class.new('prefix', 'http://example.com') }

    it 'should also work in the expected ruby sense' do
      expect(prefix.class).to eq(described_class)
    end

  end

end
