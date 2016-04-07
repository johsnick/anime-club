class VoteConfig < ActiveRecord::Base
  validate :valid_config?

  private
    def valid_config?
      begin 
        Time.parse(self.stop_voting_time).in_time_zone(self.timezone)
        unless (1..7).include?(self.stop_voting_day)
          raise 'probs are a thing'
        end
      rescue => e 
        errors.add(:config, 'invalid config')
      end
    end
end
