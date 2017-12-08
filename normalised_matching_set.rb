module AquaeMatch
  class NormalisedMatchingSet
    attr_reader :surname, :year_of_birth, :month_of_birth, :day_of_birth, :postcode

    def initialize surname, year_of_birth, month_of_birth, day_of_birth, postcode
      raise ArgumentError, "Surname is required" if surname.nil?
      @surname = surname
      @year_of_birth = year_of_birth
      @month_of_birth = month_of_birth
      @day_of_birth = day_of_birth
      @postcode = postcode
    end
  end
end
