class Show < ActiveRecord::Base
  has_many :votes, dependent: :destroy
  attr_accessor :voted
end
