module OntologyUnited
  module DSL
    class BaseDSL
      extend Stack::Delegate

      class << self
        include Stack

        attr_writer :stack
        attr_reader :the_attr_readers

        def attr_reader_with_default(*readers, default: nil)
          raise ArgumentError, 'Default value for reader needed' if default.nil?
          attr_reader *readers
          @the_attr_readers ||= {}
          klass = default.is_a?(Class) ? default : default.class
          readers.each { |reader| @the_attr_readers[reader] = klass }
        end

      end

      def establish_defaults
        self.class.the_attr_readers.each do |var, klass|
          self.instance_variable_set(:"@#{var}", klass.new)
        end
      end

      delegate_stack_to { |base_dsl| base_dsl.class }

    end
  end
end
