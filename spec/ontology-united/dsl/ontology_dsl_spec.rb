require 'spec_helper'

describe OntologyUnited::DSL::OntologyDSL do

  context '.define' do
    let(:ontology) do
      described_class.define('Foo') do |this|
        this.class('Something')
      end
    end

    it 'should be allowed to use an ontology argument in the block' do
      expect { ontology }.not_to raise_error
    end
  end

end
