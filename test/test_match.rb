require 'test-unit'
require_relative '../match'
require_relative '../normalised_matching_set'
require_relative '../datasource/memory'

class MatchTest < Test::Unit::TestCase
  JONES_RECORD = AquaeMatch::DataSource::Memory::Record.new('WORTH1', 'Jones', 1990, 9, 19, 'SW115XS')
  SMITH_RECORD = AquaeMatch::DataSource::Memory::Record.new('WORTH2', 'Smith', 1980, 8, 18, 'N61TL')
  JONES_TWIN_RECORD = AquaeMatch::DataSource::Memory::Record.new('WORTH3', 'Jones', 1990, 9, 19, 'SW115XS')

  def mds_fixture attributes={}
    default = {
        :surname => JONES_RECORD.surname,
        :year_of_birth => JONES_RECORD.year,
        :month_of_birth => JONES_RECORD.month,
        :day_of_birth => JONES_RECORD.day,
        :postcode => JONES_RECORD.postcode
    }
    args = default.update(attributes)
    AquaeMatch::NormalisedMatchingSet.new args[:surname], args[:year_of_birth], args[:month_of_birth], args[:day_of_birth], args[:postcode]
  end

  def match mds, data=[]
    integration = AquaeMatch::DataSource::Memory.new data
    matcher = AquaeMatch::Match.new integration
    matcher.match mds
  end

  def assert_match mds, match, *other
    result = match(mds, [match] + other)
    assert_not_nil result, "There was no match"
    assert_equal match[:key], result, "The matched row was incorrect"
  end

  test 'match for empty mds throws error' do
    assert_raise(ArgumentError) {match(nil)}
  end

  test 'match for missing attributes throws error' do
    assert_raise(ArgumentError) { match(mds_fixture(surname: nil))}
  end

  test 'match using single row database returns result' do
    mds = mds_fixture
    assert_match mds, JONES_RECORD
  end

  test 'non-match from surname using single row' do
    mds = mds_fixture surname: 'Smith'
    assert_nil match(mds, [JONES_RECORD])
  end

  test 'non-match from year of birth using single row' do
    mds = mds_fixture year_of_birth: 1980
    assert_nil match(mds, [JONES_RECORD])
  end

  test 'non-match from month of birth using single row' do
    mds = mds_fixture month_of_birth: 8
    assert_nil match(mds, [JONES_RECORD])
  end

  test 'non-match from day of birth using single row' do
    mds = mds_fixture day_of_birth: 18
    assert_nil match(mds, [JONES_RECORD])
  end

  test 'non-match from postcode using single row' do
    mds = mds_fixture postcode: 'N61TL'
    assert_nil match(mds, [JONES_RECORD])
  end

  test 'match from missing day of birth using single row' do
    mds = mds_fixture day_of_birth: nil
    assert_match mds, JONES_RECORD
  end

  test 'match from missing month of birth using single row' do
    mds = mds_fixture month_of_birth: nil
    assert_match mds, JONES_RECORD
  end

  test 'match from missing year of birth using single row' do
    mds = mds_fixture year_of_birth: nil
    assert_match mds, JONES_RECORD
  end

  test 'match from missing postcode using single row' do
    mds = mds_fixture postcode: nil
    assert_match mds, JONES_RECORD
  end

  test 'match using two rows returns correct result' do
    mds = mds_fixture
    assert_match mds, JONES_RECORD, SMITH_RECORD
  end

  test 'match returns nil if multiple rows are matched' do
    mds = mds_fixture
    assert_nil match(mds, [JONES_RECORD, SMITH_RECORD, JONES_TWIN_RECORD])
  end
end