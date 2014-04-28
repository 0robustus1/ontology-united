require 'spec_helper'

describe OntologyUnited::Convenience do
  include OntologyUnited::Convenience

  context 'when defining a valid ontology' do
    let(:ontology) do
      define_ontology('Foo') do
        ontology_class('Something')
      end
    end

    it 'should raise no errors' do
      expect { ontology }.not_to raise_error
    end

    it 'should return an ontology instance' do
      expect(ontology).to be_instance_of(OntologyUnited::DSL::Ontology)
    end


  end

end
