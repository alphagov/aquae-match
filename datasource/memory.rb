module AquaeMatch
  module DataSource
    class Memory
      def initialize source=[]
        unless source.all? {|record| RecordFields.all? {|field| record.respond_to? field } }
          raise ArgumentError, "Expected input data to have fields #{RecordFields.inspect}"
        end
        @source = source
      end

      RecordFields = [:key, :surname, :year, :month, :day, :postcode]
      Record = Struct.new *RecordFields

      def all_records
        @source
      end

      def single? set
        set.one?
      end

      def where_attribute_equal set, name, value
        set.select {|record| record.send(name) == value }
      end

      def where_attribute_equal_or_missing set, name, value
        set.select {|record| record.send(name) == value || value.nil? || record.send(name).nil? }
      end

      def key_from_single_record records
        records[0].key
      end
    end
  end
end