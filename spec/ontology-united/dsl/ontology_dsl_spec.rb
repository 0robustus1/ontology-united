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

    context 'inner definition of ontology' do
      let(:outer) do
        described_class.define('Foo') do
          define('Bar', as: :bar_ontology) do |this|
            this.class('Something')
          end
        end
      end

      it 'should contain variable-assignment for inner ontology' do
        expect(outer.bar_ontology.name).to eq('Bar')
      end
    end
  end

end
