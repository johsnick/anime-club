class User < ActiveRecord::Base
  # Include default devise modules.
  devise  :registerable, :recoverable,
          :rememberable, :trackable, :validatable,
          :omniauthable, :database_authenticatable

  include DeviseTokenAuth::Concerns::User

  has_many :votes, dependent: :destroy
  has_many :shows, through: :votes

  def voted_for?(show)
    self.shows.pluck(:id).include?(show.id)
  end

  def inject_voted(shows)
    id_array = self.shows.pluck(:id)
    shows.each do |show|
      show.voted = id_array.include?(show.id)
    end 
    shows
  end
end