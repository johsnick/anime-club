class VoteConfigController < ApplicationController
  before_action :authenticate_user!, except: [:index, :new]

  def show
    render json: VoteConfig.first.to_json
  end

  def toggle_voting
    config = VoteConfig.first
    config.active = params[:active]
    config.save

    render json: config
  end

  def activate_voting_hardcore
    config = VoteConfig.first
    config.active = true
    config.save 

    Vote.where(vote_type: 'super').update_all(active: false)
    Vote.where.not(active: false).destroy_all

    Show.update_all(vote_count: 0)
    
    render json: config
  end

  def update
    config = VoteConfig.first
    config.stop_voting_time = params[:stop_voting_time] if params[:stop_voting_time].present?
    if params[:stop_voting_day].present?
      day = nil
      case params[:stop_voting_day]
      when 'Monday'
        day = 1
      when 'Tuesday'
        day = 2
      when 'Wednesday'
        day = 3
      when 'Thursday'
        day = 4
      when 'Friday'
        day = 5
    when 'Saturday'
        day = 6
      when 'Sunday'
        day = 7
      end
      config.stop_voting_day = day
    end
    config.timezone = params[:timezone] if params[:timezone]
    if config.save
      render json: {}
    else 
      render json: config.errors, status: 400
    end
  end 
end
