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
end
