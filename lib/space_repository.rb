require_relative "./space"

class SpaceRepository

    def all
        #lists all spaces
        sql = 'SELECT * FROM spaces'
        data = DatabaseConnection.exec_params(sql, [])
        spaces = []
        data.each do |record|
          
            spaces << create_instance_of_space(record)
        end
        return spaces
    end 

    def find(id)
        #finds a particular space
        sql = 'SELECT * FROM spaces WHERE id = $1'
        params = id
        p data = DatabaseConnection.exec_params(sql, [params])[0]
        return create_instance_of_space(data)
    end

    def new_space(space)
        #adds new space to listing
        sql = 'INSERT INTO spaces(name, description, ppn, contact, user_id) VALUES($1, $2, $3, $4, $5);'
        result = DatabaseConnection.exec_params(sql, [space.name, space.description, space.ppn, space.contact, space.user_id])

        return space
    end
    
    def update_space(id)
        #updates any information on the space
    end

    def delete_space(id)
        #deletes a specific space
    end

    private

    def create_instance_of_space(space_record)
        space = Space.new()
        space.id = space_record['id']
        space.name = space_record['name']
        space.description = space_record['description']
        space.ppn = space_record['ppn']
        space.user_id = space_record['user_id']
        space.contact = space_record['contact']
        return space
    end
end
