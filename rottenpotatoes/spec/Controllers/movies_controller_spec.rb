require 'rails_helper'


describe MoviesController, :type => :controller do

    describe 'GET index' do
        let!(:movie) {Movie.create(:title => 'Avatar', :rating =>'PG-13', :release_date => '2000-01-01')}

        it 'should load the index view' do
            get :index
            expect(response).to render_template('index')
        end

        it 'should load the index view passing the title header value as the sort param' do
            get :index, { sort: 'title'}
            expect(assigns(:title_header)).to eql('hilite')
        end

        it 'should load the index view passing the title header value as the sort param' do
            get :index, { sort: 'release_date'}
            expect(assigns(:date_header)).to eql('hilite')
        end
    end
    
    describe 'GET show' do
        let!(:movie) {Movie.create(:title => 'Avatar', :rating =>'PG-13', :release_date => '2000-01-01', :director => "James Cameron")}
        
        it 'should load the movie in the details page' do
            get :show, {id: movie.id}
            expect(response).to render_template('show')
        end
    end
    
    describe 'GET new' do
        let!(:movie) {Movie.create(:title => 'Avatar', :description => 'None', :rating =>'PG-13', :release_date => '2000-01-01', :director => "James Cameron")}
        
        it 'should render the new movie page' do
            get :new
            expect(response).to render_template('new')
        end
    end
    
    describe 'GET find_same_director' do
        let!(:movie) {Movie.create(:title => 'Avatar', :rating =>'PG-13', :release_date => '2000-01-01', :director => "James Cameron")}
        
        it 'should load the movies with same director view' do
            get :find_same_director, {id: movie.id, director: movie.director}
            expect(response).to render_template('find_same_director')
        end
    end
    
    describe 'DELETE #destroy' do
        let!(:movie) {Movie.create(:title => 'Avatar', :rating =>'PG-13', :release_date => '2000-01-01', :director => "James Cameron")}

        it 'deletes the movie' do
            expect { delete :destroy, id: movie.id}.to change(Movie, :count).by(-1)
        end
    end
end

describe Movie do
    let(:movie) {Movie.create(:title => 'Avatar', :rating =>'PG-13')}
    
    it 'validates existing movie' do
        expect(Movie.all_ratings()).to include(movie.rating)
    end
end