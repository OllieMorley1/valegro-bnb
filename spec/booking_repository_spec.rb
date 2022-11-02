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

      expect(bookings.length).to eq(1)
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
      booking.approved = true
  
      repo.new_booking(booking)

      booking = repo.find(2)

      expect(booking.date).to eq("2023-01-02")
      expect(booking.space_id).to eq("2")
    end

    it "updates a booking" do
      repo = BookingRepository.new()

      booking = repo.find(1)
      booking.user_id = 1
      booking.space_id = 2
      booking.date = "2023-01-01"
      booking.approved = true
      
      repo.update_booking(booking)

      result = repo.find(1)

      expect(result.user_id).to eq("1")
      expect(result.date).to eq("2023-01-01")
    end

    it "deletes a booking" do
      repo = BookingRepository.new()

      repo.delete_booking(1)

      result = repo.all_bookings

      expect(result.length).to eq (0)
    end
end