require 'spec_helper'

describe OntologyUnited::DSL::VariableStore do
  let(:declaration_klass) do
    class DeclarationKlass
      include OntologyUnited::DSL::VariableStore::Declaration
    end
    DeclarationKlass
  end

  let(:variable_klass) do
    class VariableKlass
      include OntologyUnited::DSL::VariableStore::Helper
      attr_accessor :parent, :some_string

      def initialize(parent, some_string)
        self.parent = parent
        self.some_string = some_string
      end
    end
    VariableKlass
  end

  context 'assuming an object with parent' do
    let(:parent) { declaration_klass.new }
    let(:variable_instance) { variable_klass.new(parent, 'SomeString') }

    it 'should respond with self to a variable assignment call' do
      expect(variable_instance.as(:inner)).to eq(variable_instance)
    end

    context 'and a variable assignment' do
      before do
        variable_instance.as(:inner)
      end

      it 'should produce the same object as variable on parent' do
        expect(parent.inner).to eq(variable_instance)
      end

    end
  end

  context 'assuming an object without parent' do
    let(:variable_instance) { variable_klass.new(nil, 'SomeString') }

    it 'should raise the correct error' do
      expect { variable_instance.as(:inner) }.to raise_error(OntologyUnited::DSL::VariableStore::ParentIsNilError)
    end

  end

end
