class MatchingDataSet

  attr_reader :surname, :date_of_birth, :postcode
  def initialize surname, date_of_birth, postcode
    raise ArgumentError if surname.nil? || date_of_birth.nil? || postcode.nil?
    @surname = surname
    @date_of_birth = date_of_birth
    @postcode = postcode
  end

end
