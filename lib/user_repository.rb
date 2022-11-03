require_relative './user'
require 'bcrypt'
class UserRepository

    # def all
    #     #returns list of all the users
    # end 

    def find_user(id)
        #find a user using id
        sql = 'SELECT * FROM users WHERE id = $1;'
        result = DatabaseConnection.exec_params(sql, [id])[0]
        return create_instance_of_user(result)
    end

    def new_user(user)
        #creates new user
        encrypted_password = BCrypt::Password.create(user.password)

        sql = 'INSERT INTO users(name, email, password) VALUES($1, $2, $3);'
        DatabaseConnection.exec_params(sql, [user.name, user.email, encrypted_password])
    end
    
    def update_user(user)
        #updates user information
        sql = 'UPDATE users SET name = $1, email = $2, password = $3 WHERE id = $4;'
        params = [user.name, user.email, user.password, user.id]
        DatabaseConnection.exec_params(sql, params)

    end

    def delete_user(id)
        #deletes a user's account
        sql = 'DELETE FROM users WHERE id= $1;'
        DatabaseConnection.exec_params(sql, [id])
    end

    def find_by_email(email)
        #find a user using email
        sql = 'SELECT * FROM users WHERE email = $1;'
        result = DatabaseConnection.exec_params(sql, [email])[0]
        return create_instance_of_user(result)
    end

    private

    def create_instance_of_user(record)
        user = User.new
        user.id = record['id']
        user.name = record['name']
        user.email = record['email']
        user.password = record['password']
        
        return user
    end

end
