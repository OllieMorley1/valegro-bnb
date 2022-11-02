require "user_repository"


def reset_users_table
    seed_sql = File.read('spec/makers_bnb_valegro.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'valegrobnb_test' })
    connection.exec(seed_sql)
  end

  RSpec.describe UserRepository do

    before(:each) do 
      reset_users_table
    end

    it "find a user" do
        repo = UserRepository.new()
        user = repo.find_user(1)

        expect(user.name).to eq("Ilyas")
    end

    it "create a new user" do
        repo = UserRepository.new()

        user = User.new()
        user.name = "Emma"
        user.email = "teuf@gmail.com"
        user.password = "1h2g378GJG5"

        repo.new_user(user)

        result = repo.find_user(6)

        expect(result.name).to eq("Emma")
        expect(result.password).to eq("1h2g378GJG5")
    end

    it "update a user" do
        repo = UserRepository.new()
        user = repo.find_user(1)
        user.name = "IlyasNew"
        user.email = "newEmail"
        user.password = "NewPassword"
        repo.update_user(user)
        user = repo.find_user(1)
        expect(user.name).to eq("IlyasNew")
        expect(user.password).to eq("NewPassword")
    end
    
    it "delete a user" do 
        repo = UserRepository.new
        user = User.new()
        user.name = "Emma"
        user.email = "teuf@gmail.com"
        user.password = "1h2g378GJG5"

        repo.new_user(user)
        repo.delete_user(6)
        expect{repo.find_user(6)}.to raise_error 
    end 

end

# :id, :name, :email, :password