require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/space_repository'
require_relative 'lib/booking_repository'
require_relative 'lib/database_connection'
require_relative 'lib/user_repository'
# require 'bcrypt'

DatabaseConnection.connect('valegrobnb_test')

class Application < Sinatra::Base
  enable :sessions
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
    id = params[:id]
    @space = repo.find(id)

    @space.name = params[:name]
    @space.description = params[:description]
    @space.ppn = params[:ppn] #price_per_night
    @space.contact = params[:contact]
    repo.update_space(@space)

    return redirect('/spaces')
  end
  
  ##################################### BOOKING ###############################


  get '/bookings/:id' do
    @id = params[:id]
    repo = BookingRepository.new
    @booking = repo.find(@id)
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
    
    x = repo.all_bookings.length
    return redirect("/bookings/#{x}")

  end



  #this is route is used for testing
  get '/test' do 
    return erb(:test)
  end



  ##################### USERS ######################

  get '/sign_up' do 
    
    return erb(:sign_up)
  end 

  post '/sign_up' do
    repo = UserRepository.new
    user = User.new
    user.name = params[:name]
    user.password = params[:password]
    user.email = params[:email]
    repo.new_user(user)
    return erb(:login)
  end

  get '/login' do
    return erb(:login)
  end

  post '/login' do
    email = params[:email]
    password = params[:password]
    repo = UserRepository.new
    user = repo.find_by_email(email)

    if BCrypt::Password.new(user.password) == password
      # Set the user ID in session
      session[:user_id] = user.id
  #login succesful please click ok to get to the homepage
      return erb(:login_success)

    else
  #wrong logins please try again or sign up.
      return erb(:login_error)
    end
  end

  get '/account_page' do
    if session[:user_id] == nil
      # No user id in the session
      # so the user is not logged in.
      return redirect('/login')
    else
      # The user is logged in, display 
      # their account page.
      repo = UserRepository.new
      @user = repo.find_user(session[:user_id])
      return erb(:account)
    end
  end

  post '/account_page/update' do
    repo = UserRepository.new
    id = params[:id]
    @user = repo.find_user(id)
    @user.name = params[:name]
    @user.email = params[:email]
    @user.password = params[:password]
    repo.update_user(@user)
    
    return erb(:account)
  end

  post '/delete' do
    password = params[:password]
    repo = UserRepository.new
    user = repo.find_user(session[:user_id])
    if user.password == password
      repo.delete_user(session[:user_id])
      return erb(:login)
    else 
      return erb(:delete_error)
    end
  end

end