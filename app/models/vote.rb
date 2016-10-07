class Vote < ActiveRecord::Base
  belongs_to :show
  belongs_to :user

  after_create :update_vote_count
  before_create :type_to_value
  before_destroy :reduce_vote_count

  validate :valid_vote?

  default_scope { where(active: true) }

  def update_vote_count
    show = self.show
    show.vote_count += self.value
    show.save
  end

  def reduce_vote_count
    show = self.show
    show.vote_count -= self.value
    show.save
  end

  def type_to_value
    case self.vote_type
    when 'down'
      self.value = -1
    when 'super'
      self.value = 3
    else
      self.value = 1
    end
  end

  def valid_vote?
    config = VoteConfig.first

    errors.add(:votes, 'Voting disabled') unless config.active

    case self.vote_type
    when 'super'
      unless Vote.unscoped.where(user: user, vote_type: 'super').count == 0
        errors.add(:votes, 'Already used Super Vote')
      end
    when 'down'
      unless user.votes.where(vote_type: 'down').count == 0
        errors.add(:votes, 'Already used Down Vote')
      end
    else
      unless user.votes.where(vote_type: 'default').count < 3
        errors.add(:votes, 'Already used 3 Votes')
      end
    end
  end
end
