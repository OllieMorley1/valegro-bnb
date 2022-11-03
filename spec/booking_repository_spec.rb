require "booking_repository"

def reset_bookings_table
    seed_sql = File.read('spec/makers_bnb_valegro.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'valegrobnb_test' })
    connection.exec(seed_sql)
  end

  RSpec.describe BookingRepository do

    before(:each) do 
      reset_bookings_table
    end

    it "returns all the bookings" do
      repo = BookingRepository.new()
      bookings = repo.all_bookings

      expect(bookings.length).to eq(3)
    end

    it "return a specific booking " do
      repo = BookingRepository.new()
      booking = repo.find(1)

      expect(booking.date).to eq('2022-11-02')
      expect(booking.user_id).to eq("1")
      expect(booking.space_id).to eq("2")
    end

    it "create a new booking" do
      repo = BookingRepository.new()

      booking = Booking.new()
      booking.user_id = 1
      booking.space_id = 2
      booking.date = "2023-01-02"
      booking.status = "approved"
  
      repo.new_booking(booking)

      booking = repo.find(4)

      expect(booking.date).to eq("2023-01-02")
      expect(booking.space_id).to eq("2")
    end

    it "updates a booking" do
      repo = BookingRepository.new()

      booking = repo.find(1)
      booking.user_id = 1
      booking.space_id = 2
      booking.date = "2023-01-01"
      booking.status = "approved"
      
      repo.update_booking(booking)

      result = repo.find(1)

      expect(result.user_id).to eq("1")
      expect(result.date).to eq("2023-01-01")
    end

    it "deletes a booking" do
      repo = BookingRepository.new()

      repo.delete_booking(1)

      result = repo.all_bookings

      expect(result.length).to eq (2)
    end

    it "approve a booking" do 
      repo = BookingRepository.new()

      booking = repo.find(1)

      repo.approve_booking(booking)

      booking = repo.find(1)

      expect(booking.status).to eq("approved")
    end

    it "reject a booking" do 
      repo = BookingRepository.new()

      booking = repo.find(1)

      repo.reject_booking(booking)

      booking = repo.find(1)

      expect(booking.status).to eq("rejected")
    end

    it "return all bookings to space owner" do 
      repo = BookingRepository.new()

      bookings = repo.return_space_owner_bookings(2)

      expect(bookings.length).to eq(1)
    end 

    it "return all approved bookings to user" do
      repo = BookingRepository.new()

      bookings = repo.return_approve_bookings(1)

      expect(bookings.length).to eq(1)
    end

    it "return all rejected bookings to user" do
      repo = BookingRepository.new()

      bookings = repo.return_rejected_bookings(1)

      expect(bookings.length).to eq(1)
    end

    it "return all pending bookings to user" do
      repo = BookingRepository.new()

      bookings = repo.return_pending_bookings(1)

      expect(bookings.length).to eq(1)
    end

end