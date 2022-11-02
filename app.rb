require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/space_repository'
require_relative 'lib/database_connection'

DatabaseConnection.connect('valegrobnb_test')

class Application < Sinatra::Base
  # This allows the app code to refresh
  # without having to restart the server.
  configure :development do
    register Sinatra::Reloader
  end

  #form for listing a new space
  get '/spaces/new' do
    return erb(:newspace)
  end

  #returns a page, listing all spaces. 
  #Each space links to its individual page with more details/ability to book.
  get '/spaces' do
    repo = SpaceRepository.new
    @spaces = repo.all
    return erb(:spaces)
  end

  #returns the page for an individual space, depending on id given
  get '/spaces/:id' do
    @id = params[:id]

    repo = SpaceRepository.new
    @space = repo.find(@id)
    return erb(:space)
  end
  
    post '/spaces/:id' do
      repo = SpaceRepository.new
      id = params[:id]
      repo.delete_space(id)
      return redirect ('/spaces')
    end
  
  # this route receives params from an erb form and creates a new Space
  post '/spaces' do
    repo = SpaceRepository.new
    @space = Space.new

    @space.name = params[:name]
    @space.description = params[:description]
    @space.ppn = params[:ppn] #price_per_night
    @space.contact = params[:contact]
    repo.new_space(@space)

    return redirect('/spaces')
  end
#this route will update a space
  get '/update/:id/edit' do
    repo = SpaceRepository.new
    id = params[:id]
    @space = repo.find(id)
    return erb(:update_space)
  end

  post '/update/:id' do
    repo = SpaceRepository.new
    p id = params[:id]
    @space = repo.find(id)

    @space.name = params[:name]
    @space.description = params[:description]
    @space.ppn = params[:ppn] #price_per_night
    @space.contact = params[:contact]
    repo.update_space(@space)

    return redirect('/spaces')
  end
  
  ##################################### BOOKING ###############################


  get 'bookings/:id' do
    return erb(:booking)
  end

  post '/bookings' do
    repo = BookingRepository.new
    @booking = Booking.new
#:id, :user_id, :space_id, :date, :approved
    # @booking.user_id = params[:user_id]
    @booking.space_id = params[:space_id]
    @booking.date = params[:date] 
    # @booking.contact = params[:contact]
    # @booking.approved = false
    repo.new_booking(@booking)


    return redirect("/bookings/#{@booking.space_id}")
  end



  #this is route is used for testing
  get '/test' do 
    return erb(:test)
  end

end