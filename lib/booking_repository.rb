require_relative "./booking"

class BookingRepository

    def all_bookings
        # lists all of the bookings
        sql = 'SELECT * FROM bookings;'
        data = DatabaseConnection.exec_params(sql, [])

        bookings = []

        data.each do |record|
            bookings << create_instance_of_booking(record)
        end
        return bookings
    end
    
    def users_bookings
        #list all of the users bookings
    end 

    def find(id)
        #finds a particular booking
        sql = 'SELECT * FROM bookings WHERE id = $1;'
        params = id
        data = DatabaseConnection.exec_params(sql, [params])[0]
        return create_instance_of_booking(data)
    end

    def new_booking(booking)
        #creates a new booking
        sql = 'INSERT INTO bookings(user_id, space_id, date, approved) VALUES($1, $2, $3, $4);'
        DatabaseConnection.exec_params(sql, [booking.user_id, booking.space_id, booking.date, booking.approved])

        return booking
    end
    
    def update_booking(booking)
        #updates any booking information
        sql = 'UPDATE bookings SET user_id = $1, space_id = $2, date = $3, approved = $4 where id = $5;'
        params = [booking.user_id, booking.space_id, booking.date, booking.approved, booking.id]
        DatabaseConnection.exec_params(sql, params)
    end

    def delete_booking(id)
        #deletes a booking
        sql = 'DELETE FROM bookings WHERE id=$1;'
        DatabaseConnection.exec_params(sql, [id])
    end

    private

    def create_instance_of_booking(booking_record)
        booking = Booking.new()
        booking.id = booking_record['id']
        booking.user_id = booking_record['user_id']
        booking.space_id = booking_record['space_id']
        booking.date = booking_record['date']
        booking.approved = booking_record['approved']
        return booking
    end
end

