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

  context 'variable store' do
    let(:ontology) do
      OntologyUnited::DSL::OntologyDSL.define('Foo') do
        this = prefix('this', as: :this_prefix)
        this.class('Something', as: :something_class)
        this.class('Something').sub_class_of this.class('Other'), as: :sub_class_sentence
      end
    end

    context '.prefix' do
      it 'should not contain a nily variable assignment' do
        expect(ontology.this_prefix).to_not be_nil
      end

      it 'should contain a variable assignment with correct prefix' do
        expect(ontology.this_prefix.prefix).to eq('this')
      end
    end

    context '.class' do
      it 'should not contain a nily variable assignment' do
        expect(ontology.something_class).to_not be_nil
      end

      it 'should contain a variable assignment with correct name' do
        expect(ontology.something_class.name).to eq('Something')
      end
    end

    context 'sub_class_of sentence' do
      it 'should not contain a nily variable assignment' do
        expect(ontology.sub_class_sentence).to_not be_nil
      end
    end

  end


end
