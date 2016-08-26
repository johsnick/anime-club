class AnimelistController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def search
    auth = {username: 'swordlord936', password: 'wLUdb3MGTl4hG7x2'}
    response = HTTParty.get('http://myanimelist.net/api/anime/search.json',
                            basic_auth: auth,
                            query: {q: params[:query],
                                    type: 'anime'})

    if response.nil?
      render json: {error: 'No Results Found'}, status: 404
      return
    end

    animes = response['anime']['entry']
    if animes.class != Array 
      animes = [animes]
    end

    results = []
    animes.each do |anime|
      show = Show.unscoped.find_by(animelist_id: anime['id'])
      show.voted = current_user.voted_for?(show) if show.present?
      results << (show.present? ? show : anime)
    end

    render json: results.to_json(methods: :voted)
  end

  def index
  end
end
