require 'time'
require_relative 'mds'

module AquaeMatch
  class Match
    def initialize(source)
      @source = source
    end

    # Matching
    # @return id | nil
    # @param [MatchingDataSet] mds
    #   A set of matching data with each attribute normalised
    def match(mds)
      raise ArgumentError if mds.nil?
      candidates = search_by_surname_dob(mds)
      filtered_candidates = filter_by_addresses(mds, candidates)
      single?(filtered_candidates) ? key_from_single_record(filtered_candidates) : nil
    end

    def single?(filtered_candidates)
      @source.single? filtered_candidates
    end

    def filter_by_addresses(mds, candidates)
      @source.where_attribute_equal_or_missing candidates, :postcode, mds.postcode
    end

    def search_by_surname_dob(mds)
      # We are saying that a "normalised" MDS is input into the algorithm.
      # Which part of the code is responsible for normalising? Here?
      year, month, day = split_dob(mds.date_of_birth)
      set = @source.all_records
      set = @source.where_attribute_equal(set, :surname, mds.surname)
      set = @source.where_attribute_equal_or_missing(set, :year, year)
      set = @source.where_attribute_equal_or_missing(set, :month, month)
      set = @source.where_attribute_equal_or_missing(set, :day, day)
    end

    def key_from_single_record(record)
      @source.key_from_single_record(record)
    end

    def split_dob(date)
      parsed = DateTime.parse(date)
      [parsed.year, parsed.month, parsed.day]
    end
  end
end