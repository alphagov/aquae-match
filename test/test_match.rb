require 'test-unit'
require_relative '../match'
require_relative '../datasource/memory'

class MatchTest < Test::Unit::TestCase
  LEGIT_RECORD = AquaeMatch::DataSource::Memory::Record.new('WORTH1', 'Jones', 1990, 9, 19, 'SW115XS')

  def mds_fixture attributes
    default = {
        :surname => 'MacTesty',
        :date_of_birth => '01/01/1970',
        :postcode => 'A12 B34'
    }
    args = default.update(attributes)
    MatchingDataSet.new args[:surname], args[:date_of_birth], args[:postcode]
  end

  def match mds, data=[]
    integration = AquaeMatch::DataSource::Memory.new data
    matcher = AquaeMatch::Match.new integration
    matcher.match mds
  end

  test 'match for empty mds throws error' do
    assert_raise(ArgumentError) {match(nil)}
  end

  test 'match for missing attributes throws error' do
    assert_raise(ArgumentError) { match(mds_fixture(surname: nil))}
    assert_raise(ArgumentError) { match(mds_fixture(date_of_birth: nil))}
    assert_raise(ArgumentError) { match(mds_fixture(postcode: nil))}
  end

  test 'match using single row database returns result' do
    mds = mds_fixture surname: 'Jones', date_of_birth: '19/09/1990', postcode: 'SW115XS'
    result = match(mds, [LEGIT_RECORD])
    assert_not_nil result
    assert_equal LEGIT_RECORD[:key], result
  end
end