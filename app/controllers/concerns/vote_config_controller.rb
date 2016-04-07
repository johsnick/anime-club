class VoteConfigController < ApplicationController
  before_action :authenticate_user!, except: [:index, :new]

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
