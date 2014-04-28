require 'spec_helper'

describe OntologyUnited::DSL::Ontology do

  context '#file' do
    let(:ontology) do
      OntologyUnited::DSL::OntologyDSL.define('Foo') do
        ontology_class('Something')
      end
    end

    it 'should produce an existing file' do
      expect(File.exist?(ontology.file.path)).to be_true
    end

  end


end
