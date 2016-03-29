namespace :voting do 
  task :maintain do 
    Vote.where(vote_type: nil).destroy_all
    Vote.where(vote_type: 'down').destroy_all

    show = Show.find_by(show_type: 'Random Pick')
    show.show_type = nil
    show.save 

    show = Show.order('random()').first
    show.show_type = 'Random Pick'
    show.save
  
    shows = Show.order(:vote_count).offset(4).where('vote_count > 0')
  end
end