require 'spec_helper'

describe OntologyUnited::DSL::OntologyEntityBase do

  context '.delegate_equality_to' do

    context 'when delegating to a method' do
      let(:klass) do
        class MethodClass < described_class
          delegate_equality_to method: :name

          def initialize(name)
            @name = name
          end

          def name
            @name
          end
        end
        MethodClass
      end

      let(:person) { klass.new('Person') }
      let(:same_person) { klass.new('Person') }
      let(:someone) { klass.new('Someone') }


      it 'should be equal if methods return values are equal' do
        expect(person).to eql(same_person)
      end

      it 'should be not equal if methods return values are not equal' do
        expect(someone).not_to eql(person)
      end

      it 'should be equal(==) if methods return values are equal' do
        expect(person).to eq(same_person)
      end

      it 'should be not equal(==) if methods return values are not equal' do
        expect(someone).not_to eq(person)
      end

      it 'hash should be the same if return values are the same' do
        expect(person.hash).to eql(same_person.hash)
      end

      it 'hash should be not the same if return values are not the same' do
        expect(someone.hash).not_to eql(person.hash)
      end

    end

    context 'when delegating to a method' do
      let(:klass) do
        class MethodClass < described_class
          delegate_equality_to variable: :name

          def initialize(name)
            @name = name
          end

        end
        MethodClass
      end

      let(:person) { klass.new('Person') }
      let(:same_person) { klass.new('Person') }
      let(:someone) { klass.new('Someone') }


      it 'should be equal if variable values are equal' do
        expect(person).to eql(same_person)
      end

      it 'should be not equal if variable values are not equal' do
        expect(someone).not_to eql(person)
      end

      it 'should be equal(==) if variable values are equal' do
        expect(person).to eq(same_person)
      end

      it 'should be not equal(==) if variable values are not equal' do
        expect(someone).not_to eq(person)
      end

      it 'hash should be the same if variable values are the same' do
        expect(person.hash).to eql(same_person.hash)
      end

      it 'hash should be not the same if variable values are not the same' do
        expect(someone.hash).not_to eql(person.hash)
      end

    end

  end

end
