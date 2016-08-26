class ShowsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :new]

  def index
  end

  def vote_page
    shows = Show.order('vote_count DESC').where(show_type: nil)
    current_user.inject_voted(shows)
    render json: shows.to_json( methods: [:voted])
  end

  def new
  end

  def make_ongoing
    old_show = Show.find_by(show_type: 'Ongoing Series')
    if old_show.present?
      old_show.show_type = nil
      old_show.save!
    end

    show = Show.find params[:id]
    show.show_type = 'Ongoing Series'
    show.save!
    show.votes.destroy_all

    render json: show
  end

  def create
    show = Show.new
    show.description = params[:description]
    show.animelist_id = params[:animelist_id]
    show.photo = params[:photo]
    show.name = params[:name]
    show.save 
    render json: show
  end

  def this_week
    shows = Show.order(:show_type, vote_count: :desc)
    current_user.inject_voted(shows)
    render json: shows.to_json(methods: [:voted])
  end

  def rand 
    show = Show.find_by(show_type: 'Random Pick')
    render json: show
  end

  def remove_random 
    show = Show.find_by(show_type: 'Random Pick')
    show.update(show_type: nil)

    render json: show
  end

  def destroy 
    show = Show.find(params[:id])
    show.banned = true
    show.votes.destroy_all
    show.save!
    render json: {}
  end

  def unban
    show = Show.unscoped.find(params[:id])
    show.banned = false
    show.save!
    render json: show
  end

  def new_random
    show = Show.find_by(show_type: 'Random Pick')
    if show.present?
      show.show_type = nil
      show.save!
    end

    show = Show.fetch_random
    show.show_type = 'Random Pick'
    show.save!

    render json: show
  end
end
