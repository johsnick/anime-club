class AnimelistController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def search
    auth = {username: 'swordlord936', password: 'wLUdb3MGTl4hG7x2'}
    response = HTTParty.get('http://myanimelist.net/api/anime/search.xml',
                            basic_auth: auth,
                            query: {q: params[:query]})
    animes = response['anime']['entry']
    results = []
    animes.each do |anime|
      show = Show.find_by(animelist_id: anime['id'])
      show.voted = current_user.voted_for?(show) if show.present?
      results << (show.present? ? show : anime)
    end

    render json: results.to_json(methods: :voted)
  end

  def index
  end
end
