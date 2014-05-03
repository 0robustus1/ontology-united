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

  describe OntologyUnited::Stack::Delegate do

    context '.delegate_stack_to' do
      let(:klass) do
        class Klass
          extend OntologyUnited::Stack
        end
        Klass
      end

      let(:subklass) do
        class SubKlass < klass
          extend OntologyUnited::Stack::Delegate

          delegate_stack_to { |subklass| subklass.class.superclass }
        end
        SubKlass
      end

      let(:instance) { subklass.new }

      before do
        klass.instance_variable_set(:@stack, [])
      end

      context 'alias SubKlass#stack to Klass.stack' do
        it 'should equal empty stack on default' do
          expect(instance.stack).to be_empty
        end

        it 'should equal the superclass stack on push' do
          klass.stack.push(1)
          expect(instance.stack).to eq(klass.stack)
        end
      end

      context 'alias SubKlass#current to Klass.current' do
        it 'should equal to empty stack on default' do
          expect(instance.current).to be_nil
        end

        it 'should equal the superclass stack on push' do
          klass.stack.push(1)
          expect(instance.current).to eq(klass.current)
        end
      end

      context 'alias SubKlass#parent to Klass.parent' do
        it 'should equal nil on default' do
          expect(instance.parent).to be_nil
        end

        it 'should equal the superclass stack on push' do
          klass.stack.push(1, 2)
          expect(instance.parent).to eq(klass.parent)
        end
      end

    end

  end

end
