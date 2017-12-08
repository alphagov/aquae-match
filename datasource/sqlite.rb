require 'sqlite3'
require 'sequel'

module AquaeMatch
  module DataSource
    class Sqlite
      def initialize filename=nil
        @db = Sequel.sqlite nil
        SqliteIntegration::create_schema @db
      end

      def self.create_schema db
        db.create_table :identity do
          String :key, null: false
          String :surname, null: false
          Integer :year, null: true
          Integer :month, null: true
          Integer :day, null: true
          String :postcode, null: true
        end
      end

      def insert key, surname, year=nil, month=nil, day=nil, postcode=nil
        values = {key: key, surname: surname}
        values[:year] = year unless year.nil?
        values[:month] = month unless month.nil?
        values[:day] = day unless day.nil?
        values[:postcode] = postcode unless postcode.nil?
        @db[:identity].insert values
      end

      def all_records
        @db[:identity]
      end

      def single? set
        set.count == 1
      end

      def where_attribute_equal set, name, value
        set.where({name => value})
      end

      def where_attribute_equal_or_missing set, name, value
        set.where(Sequel.|({name => value}, {name => nil})) unless value.nil?
      end

      def key_from_single_record set
        set.limit(1).first[:key]
      end
    end
  end
end