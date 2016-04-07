class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    vote = Vote.new
    vote.show_id = params[:show_id]
    vote.vote_type = params[:vote_type]
    vote.user = current_user
    if vote.save
      render json: vote
    else
      render json: vote.errors, status: 400
    end
  end

  def reset
    Vote.destroy_all
    render json: {}
  end

  def my_votes
    shows = current_user.shows.map {|show| show.voted = true; show}
    render json: shows.to_json(methods: [:voted])
  end

  def unvote
    vote = Vote.find_by(show_id: params[:show_id], user_id: current_user.id)
    vote.destroy
    render json: vote
  end
end
