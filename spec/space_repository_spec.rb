require "space_repository"

def reset_spaces_table
    seed_sql = File.read('spec/makers_bnb_valegro.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'valegrobnb_test' })
    connection.exec(seed_sql)
  end

  RSpec.describe SpaceRepository do

    before(:each) do 
      reset_spaces_table
    end

    it "returns all spaces" do
        repo = SpaceRepository.new()
        spaces = repo.all

        expect(spaces.length).to eq(2)
        expect(spaces[0].name).to eq('Buckingham palace')
    end

    it "return a specific space " do
        repo = SpaceRepository.new()
        space = repo.find(1)

        expect(space.name).to eq('Buckingham palace')
    end

    it "create a new space" do
        repo = SpaceRepository.new()

        space = Space.new()
        space.name = 'O2 arena'
        space.description = 'Concert hall'
        space.ppn = 200
        space.user_id = 1
        space.contact = 'gg@gmail.com'

        repo.new_space(space)

        spaces = repo.all

        expect(spaces.length).to eq(3)
        expect(spaces.last.name).to eq('O2 arena')
    end

    it "update a space" do
        repo = SpaceRepository.new()
        space = repo.find(1)
       
        space.name = 'Parliament'
        space.description = 'some people are in there'
        space.contact = 'boris@gmail.com'

        repo.update_space(space)

        space = repo.find(1)

        expect(space.name).to eq('Parliament')
        expect(space.description).to eq('some people are in there')
        expect(space.contact).to eq('boris@gmail.com')

        
    end

    it "delete an entry with id 1" do
        repo = SpaceRepository.new()
        repo.delete_space(1)

        spaces = repo.all
        expect(spaces.length).to eq(1)

    end
end