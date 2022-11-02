require 'spec_helper'
require 'rack/test'
require_relative '../../app'

DatabaseConnection.connect('valegrobnb_test')

describe Application do
    # This is so we can use rack-test helper methods.
    include Rack::Test::Methods
  
    # We need to declare the `app` value by instantiating the Application
    # class so our tests work.
    let(:app) { Application.new }

    context "GET /spaces" do 
        xit "returns a list of all spaces" do 
        response = get('/spaces')

        expect(response.status).to eq 200
        expect(response.body).to include('<h1>Choose where you want to stay, or <a href="/spaces/new">list a new space</a></h1>')
        end 
    end

    context "GET /spaces/new" do
        xit "returns form to create a new space" do
            response = get('/spaces/new')
            expect(response.status).to eq 200
            expect(response.body).to include('<form action="/spaces" method="POST">')
        end
    end
    
    context "GET /spaces/:id" do
        xit 'returns details for a space with given id' do
            response = get('spaces/2')
            expect(response.status).to eq 200
            expect(response.body).to include('<h1>windsor castle</h1>')
        end
    end

    context "POST /spaces" do
        xit 'creates a new space on homepage' do
            repo = SpaceRepository.new
            space = Space.new
            post('/spaces', name: 'Emmanuel', description:'description for emma', ppn: 30, contact: '0745372838')
            response = get('/spaces')
            expect(response.status).to eq 200
            expect(response.body).to include('Emmanuel')
        end
    end

end