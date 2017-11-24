# Match Dataset
# dataset = struct.new

require_relative 'mds'

# Match = search_by(surname, date_of_birth) | filter_by(address) | is_single()


# Matching
# @return: id | nil
# @param [MatchingDataSet] mds
def match(mds)
  raise ArgumentError if mds.nil?
  candidates = search_by_surname_dob(mds)
  filtered_candidates = filter_by_addresses(mds, candidates)
  single?(filtered_candidates) ? filtered_candidates[0] : nil
end

def single?(filtered_candidates)
  filtered_candidates.one?
end

def filter_by_addresses(mds, candidates)
  # code here
end

def search_by_surname_dob(mds)
  # code here
end