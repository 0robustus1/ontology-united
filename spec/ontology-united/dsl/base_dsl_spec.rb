require 'spec_helper'

describe OntologyUnited::DSL::BaseDSL do

  context '#stack' do

    context 'should be an alias for .stack' do
      let(:instance) { described_class.new }

      it 'should be the same on default' do
        expect(instance.stack).to eq(described_class.stack)
      end

      it 'should be the same with added content' do
        described_class.stack.push('Content')
        expect(instance.stack).to eq(described_class.stack)
      end

    end

  end

  context '#current' do

    context 'should be an alias for .current' do
      let(:instance) { described_class.new }

      it 'should be the same on default' do
        expect(instance.current).to eq(described_class.current)
      end

      it 'should be the same with added content to stack' do
        described_class.stack.push('Content')
        expect(instance.current).to eq(described_class.current)
      end

    end

  end

end
