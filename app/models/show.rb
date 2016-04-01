class Show < ActiveRecord::Base
  has_many :votes, dependent: :destroy
  attr_accessor :voted

  def self.fetch_random
    where('vote_count > 0').order('random()').offset(4).first
  end
end
