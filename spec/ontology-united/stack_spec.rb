require 'spec_helper'

describe OntologyUnited::Stack do

  let(:instance) do
    class Klass
      include OntologyUnited::Stack
    end

    Klass.new
  end

  context '.stack' do
    it 'should be empty per default' do
      expect(instance.stack).to be_empty
    end

    it 'should contain a pushed element' do
      instance.stack.push(1)
      expect(instance.stack).to include(1)
    end
  end

  context '.current' do
    it 'should be nil per default' do
      expect(instance.current).to be_nil
    end

    it 'should be equal to stack.last on a two-element stack' do
      instance.stack.push(1,2)
      expect(instance.current).to eq(instance.stack.last)
    end
  end

  context '.parent' do
    it 'should be nil per default' do
      expect(instance.parent).to be_nil
    end

    it 'should be nil if only one element was pushed to the stack' do
      instance.stack.push(1)
      expect(instance.parent).to be_nil
    end

    it 'should be equal to stack.first on a two-element stack' do
      instance.stack.push(1,2)
      expect(instance.parent).to eq(instance.stack.first)
    end

    it 'should be the middle element on a three-element stack' do
      instance.stack.push(1,2,3)
      expect(instance.parent).to eq(2)
    end
  end

end
