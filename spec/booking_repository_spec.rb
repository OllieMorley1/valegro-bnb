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

  

    xit "return a specific booking " do
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

        p booking = repo.find(2)

        expect(booking.date).to eq("2023-01-02")
        expect(booking.space_id).to eq("2")

    end

   
end