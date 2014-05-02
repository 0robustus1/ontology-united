require 'spec_helper'

describe OntologyUnited::DSL::VariableStore do
  let(:declaration_klass) do
    class DeclarationKlass
      include OntologyUnited::DSL::VariableStore::Declaration
    end
    DeclarationKlass
  end

  let(:variable_klass) do
    class VariableKlass < Struct.new(:parent, :some_string)
      include OntologyUnited::DSL::VariableStore::Helper
    end
    VariableKlass
  end

  context 'assuming an object with parent' do
    let(:parent) { declaration_klass.new }
    let(:variable_instance) { variable_klass.new(parent, 'SomeString') }

    context 'and a variable_assignment' do
      before do
        variable_instance.as(:inner)
      end

      it 'should produce the same object as variable on parent' do
        expect(parent.inner).to eq(variable_instance)
      end

    end
  end

end
