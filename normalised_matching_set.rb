module AquaeMatch
  class NormalisedMatchingSet
    attr_reader :surname, :year_of_birth, :month_of_birth, :day_of_birth, :postcode

    def initialize surname, year_of_birth, month_of_birth, day_of_birth, postcode
      raise ArgumentError, "Surname is required" if surname.nil?
      raise ArgumentError, "Postcode is required" if postcode.nil?
      raise ArgumentError, "Date of birth is required" if year_of_birth.nil? and month_of_birth.nil? and day_of_birth.nil?
      @surname = surname
      @year_of_birth = year_of_birth
      @month_of_birth = month_of_birth
      @day_of_birth = day_of_birth
      @postcode = postcode
    end
  end
end
