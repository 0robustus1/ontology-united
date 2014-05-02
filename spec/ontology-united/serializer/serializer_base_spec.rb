require 'spec_helper'

describe OntologyUnited::Serializer::SerializerBase do

  let(:ontology) do
    OntologyUnited::DSL::OntologyDSL.define('Foo') do
      this = prefix('this', as: :this_prefix)
      this.class('Something', as: :something_class)
      this.class('Something').sub_class_of this.class('Other'), as: :sub_class_sentence
    end
  end

  let(:serializer) { described_class.new }

  context '.ontology?' do
    it 'should recognize an ontology correctly' do
      expect(serializer.ontology?(ontology)).to be_true
    end

    it 'should produce false for an ontology-class' do
      expect(serializer.ontology?(ontology.something_class)).to be_false
    end
  end

  context '.class?' do
    it 'should recognize an ontology-class correctly' do
      expect(serializer.class?(ontology.something_class)).to be_true
    end

    it 'should produce false for a sentence' do
      expect(serializer.class?(ontology.sub_class_sentence)).to be_false
    end
  end

  context 'sentence?' do
    it 'should recognize a sentence correctly' do
      expect(serializer.sentence?(ontology.sub_class_sentence)).to be_true
    end

    it 'should produce false for an ontology-class' do
      expect(serializer.sentence?(ontology.something_class)).to be_false
    end
  end


end
