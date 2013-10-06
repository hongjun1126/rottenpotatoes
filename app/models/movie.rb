class Movie < ActiveRecord::Base
    @all_ratings = ['G', 'PG', 'PG-13', 'R']
    @check_bool = {'G' => true, 'PG' => true, 'PG-13' => true, 'R' => true}
    def self.filter_rating
  return @all_ratings
    end
    def self.check_bool
      return @check_bool
    end
end
