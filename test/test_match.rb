require 'test-unit'
require_relative '../match'

class MatchTest < Test::Unit::TestCase
  def mds_fixture attributes
    default = {
        :surname => 'MacTesty',
        :date_of_birth => '01/01/1970',
        :postcode => 'A12 B34'
    }
    args = default.update(attributes)
    MatchingDataSet.new args[:surname], args[:date_of_birth], args[:postcode]
  end

  test 'match for empty mds throws error' do
    assert_raise(ArgumentError) {match(nil)}
  end

  test 'match for missing attributes throws error' do
    assert_raise(ArgumentError) { match(mds_fixture(surname: nil))}
    assert_raise(ArgumentError) { match(mds_fixture(date_of_birth: nil))}
    assert_raise(ArgumentError) { match(mds_fixture(postcode: nil))}
  end
end