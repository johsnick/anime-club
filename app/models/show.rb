class Show < ActiveRecord::Base
  has_many :votes, dependent: :destroy
  attr_accessor :voted

  default_scope -> { where(banned: false) }

  def self.fetch_random
    show = nil
    shows = where('vote_count > 0').to_a
    if shows.count > 4
      4.times {shows.shift}
      show = shows.sample
    else
      show = Show.where(vote_count: 0).order('random()').first
    end

    show
  end
end
